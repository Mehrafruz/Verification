
import UIKit

public typealias PreviewView = UIView & ColorSliderPreviewing

/// The display state of a preview view.
public enum PreviewState {
	/// The color is not being changed and the preview view is centered at the last modified point.
	case inactive
	
	/// The color is still being changed, but the preview view center is fixed.
	/// This occurs when a touch begins inside the slider but continues outside of it.
	/// In this case, the color is actively being modified, but the preview remains fixed at
	/// the same position that it was when the touch moved outside of the slider.
	case activeFixed
	
	/// The color is being actively changed and the preview view center will be updated to match the current color.
	case active
}

/// A protocol defining callback methods for a `ColorSlider` preview view.
///
/// To create a custom preview view, create a `UIView` subclass and implement `ColorSliderPreviewing`.
/// Then, create an instance of your custom preview view and pass it to the `ColorSlider` initializer.
/// As a user drags their finger, `ColorSlider` will automatically set your preview view's `center`
/// to the point closest to the touch, centered along the axis perpendicular to the `ColorSlider`'s orientation.
///
/// If `autoresizesSubviews` is `true` (the default value on all `UIView`s) on your `ColorSlider`, your preview view
/// will also be automatically resized when its `center` point is being set. To disable resizing your preview, set
/// the `autoresizesSubviews` property on your `ColorSlider` to `false`.

public protocol ColorSliderPreviewing {
	/// Called when the color of the slider changes, so the preview can respond correctly.
	/// - parameter color: The newly selected color.
	func colorChanged(to color: UIColor)

}
