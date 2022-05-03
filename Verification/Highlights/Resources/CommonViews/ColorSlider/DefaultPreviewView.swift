
import UIKit

///
/// The default preview view of a `ColorSlider`.
///
/// Appears to the given `side` of the associated `ColorSlider` at the point of the currently
/// selected color with an offset of `offsetAmount` and a scale given by `scaleAmounts` for a given state.
///
/// You can subclass this class and pass it as a preview to `ColorSlider` to customize its appearance or animation.
/// You may also create your own custom `UIView` and conform to the `PreviewView` protocol and pass that to `ColorSlider`'s initializer.
///

public class DefaultPreviewView: UIView {
	/// The animation duration when showing the preview. Defaults to `0.15`.
	public var animationDuration: TimeInterval = 0.15

	/// The scale of the slider for each preview state.
	/// Defaults to:
	/// * `.inactive`: `1`
	/// * `.activeFixed`: `1.2`
	/// * `.active`: `1.6`
	public var scaleAmounts: [PreviewState: CGFloat] = [.inactive: 1.0,
	                                                    .activeFixed: 1.2,
	                                                    .active: 1.6]

	
	/// The actual offset of the preview view, calculated from `offsetAmount` and `side`.
	/// This value is calculated automatically in `calculateOffset` and should only be modified externally by subclasses.
	
	/// The view that displays the current color as its `backgroundColor`.
	public let colorView: UIView = UIView()
	
	/// Enable haptics on iPhone 7 and above for state transitions to/from `.activeFixed`. Defaults to `true`.
	public var hapticsEnabled: Bool = true
	
	/// :nodoc:
	/// The last state that occurred, used to trigger haptic feedback when a selection occurs.
	fileprivate var lastState: PreviewState = .inactive
	
	/// Initialize with a specific side.
	/// - parameter side: The side of the `ColorSlider` to show on. Defaults to `.left`.
    required public init(color: UIColor) {
		colorView.backgroundColor = color
		
		super.init(frame: .zero)
		
		backgroundColor = .black
		
		// Outer shadow
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowRadius = 3
		layer.shadowOpacity = 0.2
		layer.shadowOffset = CGSize(width: 2, height: 2)
		
		// Borders
		colorView.clipsToBounds = true
		colorView.layer.borderWidth = 1.0
		colorView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
		addSubview(colorView)
		
        //calculateOffset()
	}
	
	/// :nodoc:
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// :nodoc:
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		// Automatically set the preview view corner radius based on the shortest side
		layer.cornerRadius = min(bounds.width, bounds.height) / 2
		
		// Inset the color view by 3 points, round the corners
		let colorViewFrame = bounds.insetBy(dx: 3, dy: 3)
		colorView.frame = colorViewFrame
		colorView.layer.cornerRadius = min(colorViewFrame.width, colorViewFrame.height) / 2
	}
	
	
}

extension DefaultPreviewView: ColorSliderPreviewing {
	/// Set the `backgroundColor` of `colorView` to the new `color`.
	/// - parameter color: The new color.
	public func colorChanged(to color: UIColor) {
		colorView.backgroundColor = color
	}

}
