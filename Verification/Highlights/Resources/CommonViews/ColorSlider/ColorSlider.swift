
import UIKit

/// The orientation in which the `ColorSlider` is drawn.
public enum Orientation {
	/// The horizontal orientation.
	case horizontal
	
	/// The vertical orientation.
	case vertical
}

///
/// ColorSlider is a customizable color picker with live preview.
///
/// Inspired by Snapchat, ColorSlider lets you drag to select black, white, or any color in between.
/// Customize `ColorSlider` and its preview via a simple API, and receive callbacks via `UIControlEvents`.
///
/// Use the convenience initializer to create a `.vertical` ColorSlider with a live preview that appears to the `.left` of it:
/// ```swift
/// let colorSlider = ColorSlider(orientation: .vertical, previewSide: .left)
/// ```
///
/// You can create a custom preview view using the `ColorSliderPreviewing` protocol, or by subclassing `DefaultPreviewView`.
/// To pass in a custom preview view, simply use the default initializer instead:
/// ```swift
/// let myPreviewView = MyPreviewView()
/// let colorSlider = ColorSlider(orientation: .vertical, previewView: myPreviewView)
/// ```
///
/// ColorSlider is a `UIControl` subclass and fully supports the following `UIControlEvents`:
/// * `.valueChanged`
/// * `.touchDown`
/// * `.touchUpInside`
/// * `.touchUpOutside`
/// * `.touchCancel`
///
/// Once adding your class as a target, you can get callbacks via the `color` property:
/// ```swift
/// colorSlider.addTarget(self, action: #selector(ViewController.changedColor(_:)), forControlEvents: .valueChanged)
///
/// func changedColor(_ slider: ColorSlider) {
/// 	var color = slider.color
/// 	// ...
/// }
/// ```
///
/// Customize the appearance of ColorSlider by setting properties on the `gradientView`:
/// ```swift
/// // Add a border
/// colorSlider.gradientView.layer.borderWidth = 2.0
/// colorSlider.gradientView.layer.borderColor = UIColor.white
///
/// // Disable rounded corners
/// colorSlider.gradientView.automaticallyAdjustsCornerRadius = false
/// ```
///
/// ColorSlider uses the [HSB](https://en.wikipedia.org/wiki/HSL_and_HSV) color standard internally.
/// You can set the `saturation` of your ColorSlider's `gradientView` to change the saturation of colors on the slider.
/// See the `GradientView` and `HSBColor` for more details on how colors are calculated.
///

public class ColorSlider: UIControl {
	/// The selected color.
	public var color: UIColor {
		get {
			return UIColor(hsbColor: internalColor)
		}
		set {
			internalColor = HSBColor(color: newValue)
			previewView?.colorChanged(to: color)
			sendActions(for: .valueChanged)
		}
	}
	
	/// The background gradient view.
	public let gradientView: GradientView
	
	/// The preview view, passed in the required initializer.
	public let previewView: PreviewView?
	
	/// The layout orientation of the slider, as defined in the required initializer.
	internal let orientation: Orientation
	
	/// The internal HSBColor representation of `color`.
	internal var internalColor: HSBColor

	@available(*, unavailable)
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) and storyboards are unsupported, use init(orientation:) instead.")
	}
	
	// MARK: - Init
	
	/// - parameter orientation: The orientation of the ColorSlider.
	/// - parameter side: The side of the ColorSlider on which to anchor the live preview.
    public convenience init(orientation: Orientation = .vertical, saturation: CGFloat, whiteInset: CGFloat = 0.15, blackInset: CGFloat = 0.15, previewViewColor: UIColor = .red, isMonochrome: Bool = false) {
		// Check to ensure the side is valid for the given orientation
		
		// Create the preview view
		let previewView = DefaultPreviewView(color: previewViewColor)
        self.init(orientation: orientation, saturation: saturation, whiteInset: whiteInset, blackInset: blackInset, isMonochrome: isMonochrome, previewView: previewView)
	}
	
	/// - parameter orientation: The orientation of the ColorSlider.
	/// - parameter previewView: An optional preview view that stays anchored to the slider. See ColorSliderPreviewing.
    required public init(orientation: Orientation, saturation: CGFloat, whiteInset: CGFloat, blackInset: CGFloat, isMonochrome: Bool,  previewView: PreviewView?) {
		self.orientation = orientation
		self.previewView = previewView
		
        gradientView = GradientView(orientation: orientation, saturation: saturation, whiteInset: whiteInset, blackInset: blackInset, isMonochrome: isMonochrome)
		internalColor = HSBColor(hue: 0, saturation: gradientView.saturation, brightness: 1)
		
		super.init(frame: .zero)
		
		addSubview(gradientView)
		
		if let currentPreviewView = previewView {
			currentPreviewView.isUserInteractionEnabled = false
			addSubview(currentPreviewView)
		}
	}
}


// MARK: - Layout
extension ColorSlider {
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		gradientView.frame = bounds
		
		if let preview = previewView {
			switch orientation {
			
			// Initial layout pass, set preview center as needed
			case .horizontal where preview.center.y != bounds.midY,
			     .vertical where preview.center.x != bounds.midX:
				
				if internalColor.hue == 0 {
					// Initially set preview center to the top or left
					centerPreview(at: .zero)
				} else {
					// Set preview center from `internalColor`
					let sliderProgress = gradientView.calculateSliderProgress(for: internalColor)
					centerPreview(at: CGPoint(x: sliderProgress * bounds.width, y: sliderProgress * bounds.height))
				}
				
			// Adjust preview view size if needed
			case .horizontal where autoresizesSubviews:
				preview.bounds.size = CGSize(width: 12, height: bounds.height + 8)
			case .vertical where autoresizesSubviews:
				preview.bounds.size = CGSize(width: bounds.width + 8, height: 15)
			default:
				break
			}
		}
	}
	
	/// Center the preview view at a particular point, given the orientation.
	///
	/// * If orientation is `.horizontal`, the preview is centered at `(point.x, bounds.midY)`.
	/// * If orientation is `.vertical`, the preview is centered at `(bounds.midX, point.y)`.
	///
	/// The `x` and `y` values of `point` are constrained to the bounds of the slider.
	/// - parameter point: The desired point at which to center the `previewView`.
	internal func centerPreview(at point: CGPoint) {
		switch orientation {
		case .horizontal:
			let boundedTouchX = (0..<bounds.width).clamp(point.x)
			previewView?.center = CGPoint(x: boundedTouchX, y: bounds.midY)
		case .vertical:
			let boundedTouchY = (0..<bounds.height).clamp(point.y)
			previewView?.center = CGPoint(x: bounds.midX, y: boundedTouchY)
		}
	}
}

// MARK: - UIControlEvents
extension ColorSlider {
	/// Begins tracking a touch when the user starts dragging.
	public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		super.beginTracking(touch, with: event)
		
		// Reset saturation to default value
		internalColor.saturation = gradientView.saturation

		update(touch: touch, touchInside: true)
		
		let touchLocation = touch.location(in: self)
		centerPreview(at: touchLocation)
		
		sendActions(for: .touchDown)
		sendActions(for: .valueChanged)
		return true
	}
	
	/// Continues tracking a touch as the user drags.
	public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		super.continueTracking(touch, with: event)
		
		update(touch: touch, touchInside: isTouchInside)
		
		if isTouchInside {
			let touchLocation = touch.location(in: self)
			centerPreview(at: touchLocation)
		} else {
            
		}
		
		sendActions(for: .valueChanged)
		return true
	}
	
	/// Ends tracking a touch when the user finishes dragging.
	public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		super.endTracking(touch, with: event)
		
		guard let endTouch = touch else { return }
		update(touch: endTouch, touchInside: isTouchInside)
            
		sendActions(for: isTouchInside ? .touchUpInside : .touchUpOutside)
	}
	
	/// Cancels tracking a touch when the user cancels dragging.
	public override func cancelTracking(with event: UIEvent?) {
		sendActions(for: .touchCancel)
	}
}


/// MARK: - Internal Calculations
fileprivate extension ColorSlider {
	/// Updates the internal color and preview view when a touch event occurs.
	/// - parameter touch: The touch that triggered the update.
	/// - parameter touchInside: Whether the touch that triggered the update was inside the control when the event occurred.
	func update(touch: UITouch, touchInside: Bool) {
		internalColor = gradientView.color(from: internalColor, after: touch, insideSlider: touchInside)
		previewView?.colorChanged(to: color)
	}
}


/// MARK: - Increase Tappable Area
extension ColorSlider {
	/// Increase the tappable area of `ColorSlider` to a minimum of 44 points on either edge.
	override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		// If hidden, don't customize behavior
		guard !isHidden else { return super.hitTest(point, with: event) }
		
		// Determine the delta between the width / height and 44, the iOS HIG minimum tap target size.
		// If a side is already longer than 44, add 10 points of padding to either side of the slider along that axis.
		let minimumSideLength: CGFloat = 44
		let padding: CGFloat = -20
		let dx: CGFloat = min(bounds.width - minimumSideLength, padding)
		let dy: CGFloat = min(bounds.height - minimumSideLength, padding)
		
		// If an increased tappable area is needed, respond appropriately
		let increasedTapAreaNeeded = (dx < 0 || dy < 0)
		let expandedBounds = bounds.insetBy(dx: dx / 2, dy: dy / 2)
		
		if increasedTapAreaNeeded && expandedBounds.contains(point) {
			for subview in subviews.reversed() {
				let convertedPoint = subview.convert(point, from: self)
				if let hitTestView = subview.hitTest(convertedPoint, with: event) {
					return hitTestView
				}
			}
			return self
		} else {
			return super.hitTest(point, with: event)
		}
	}
}
