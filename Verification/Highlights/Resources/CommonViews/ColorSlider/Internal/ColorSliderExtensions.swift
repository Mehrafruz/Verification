
import UIKit


internal extension Range {
	/// Constrain a `Bound` value by `self`.
	/// Equivalent to max(lowerBound, min(upperBound, value)).
	/// - parameter value: The value to be clamped.
	func clamp(_ value: Bound) -> Bound {
		return lowerBound > value ? lowerBound
			 : upperBound < value ? upperBound
			 : value
	}
}


internal extension UITouch {
	/// Calculate the "progress" of a touch in a view with respect to an orientation.
	/// - parameter view: The view to be used as a frame of reference.
	/// - parameter orientation: The orientation with which to determine the return value.
	/// - returns: The percent across the `view` that the receiver's location is, relative to the `orientation`. Constrained to (0, 1).
	func progress(in view: UIView, withOrientation orientation: Orientation) -> CGFloat {
		let touchLocation = self.location(in: view)
		var progress: CGFloat = 0
		
		switch orientation {
		case .vertical:
			progress = touchLocation.y / view.bounds.height
		case .horizontal:
			progress = touchLocation.x / view.bounds.width
		}
		
		return (0.0..<1.0).clamp(progress)
	}
}
