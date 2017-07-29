# Change Log
_All notable changes to this project will be documented in this file._

## [0.9.4](https://github.com/sky-uk/Enamel/releases/tag/v0.9.4) (Xcode 8.3.2 / Swift 3.1 compatible)

#### Swift 3.1
* Workaround the `<CALayer>.init(layer: Any)` Swift 3.1 issue (which was crashing `My Sky` app in a couple of places) by implementing it on `CALayer` subclasses that provide their own initialisers.
* Change `[String:AnyObject]` to `[String:Any]` where appropriate.
* Nest the few generic types that could not be nested in the previous versions of Swift. The renamed types are: `Dictionary.GetError`, `UIViewController.Ancestors` and `.Descendants`.
* Take advantage of the fact that Swift 3.1 now allows for some of our `BidirectionalCollection`s to conform to `RandomAccessCollection`.
* Remove `@escaping` where possible using the new `withoutActuallyEscaping` function.

#### Crack
* Crack is a testing module used to find cracks in Enamel, but one that can also be imported on its own. It's ready to use, both on macOS and iOS. To see it in action, have a look at unit tests in `Enamel/EnamelTests`.

#### CGLayout
* Change default `CGLayout` conformance implementation of `cells` for `CALayer` and `UIView` that makes them explicitly layout leaves (the wisdom of which remains to be seen in practice).
* `<CGLayout>.cells` is renamed to `childLayouts`.
* Return child’s size along the non-constrained dimension of the bar layout.
* New layouts:
    * `CGAspectFittingLayout`
    * `CGBoxLayout`
    * `CGGridLayout`
    * `CGLayoutLeaf`
    * `CGPaddingLayout`
    * `CGSizedLayout`
    * `CGSnuggingLayout`
    * `UILabel.FittingLayout`
* Remove `CGHeaderFooterLayout`.
* Remove custom `CGLayout` operators.
* Remove `padding` parameter from all layouts as padding can now be composed using `CGPaddingLayout`.
* Add some more elaborate layout examples in the playground of the `EnamelKit.workspace`.

#### CoreGraphics 
* Add static `.unit` to `CGDataSize`, `CGVector` and `CGAngle`.
* Conform `CGPolygon` to `ExpressibleByArrayLiteral` and add regular polygon initialisers.
* Add `<CGCircle>inscribedSquare`, `inscribedRect(withAspectRatioOf: CGSize)`, and `inscribedRect(withAspectRatio:)` methods (good for fitting labels inside circular indicators).
* Add `startingFrom: CGAngle` parameter to `<CGCircle>.points(count:)`.
* Add alignment parameter to `<CGRect>.incircle`.
* Remove `<CGRect>.scaledBy(xScale:yScale:)` and add `scaledBy(factor:relativeTo:)` and `Sequence<CGRect>.scaledBy(factor:relativeTo:)`.
* Improve the implementation of the `CGRectGroup` initialiser and add `aligned(anchor:position)`, `scaledBy(factor:)`, `scaledBy(factor:relativeTo:)` and `Sequence<CGRect>.group(withFrame:)`.
* Always return positive `CGSize` from `size(toFit:)` and positive scale from `scale(toFit:)`, even if the dimensions of the original two sizes are not all positive.
* Add `<FloatingPoint>.isOK` (meaning: `isNormal || isZero`) and `<FloatingPoint>.ifOK` (returns `isOK ? self : nil`) methods.
* Add dot-chain-able `abs`, `sin`, `cos`, `pow`, `log`, `log2` and `log10` properties and methods to `CGFloat`.
* Remove casting properties `i: Int` and `f: Floor` from `CGFloat`.

#### Text styling
* Rename `<String>.attributedWith(_:)` to `with(_:)` and `<NSAttributedString>.resized(toFit:)` to `sized(toFit:)`.
* Fix `Sequence<NSStringAtribute>.with(_:) -> Set` bug.
* Enrich `NSStringAttribute` apis, including `Sequence where Self == NSStringAttribute` and `Sequence where Self: NSStringAttributeType` extensions.
* To support playground and spike development using `EnamelKit`, add `UIFont.Sky` and `Sky` namespaced fonts (e.g. `UIFont.Sky.regular.font.withSize(18)` or `Sky.font.regular.withSize(18)`)

#### Misc
* Separate concerns of gradient and padded buttons by introducing `UIPaddedButton` and `UIPaddedGradientButton`.
* Turn `sum` and `product` vars on sequences to `func`s and generalise their integer api.
* Add `<UIPinchGestureRecognizer>.angle` and `orientation`.
* Add `StreacherViewController` that can be used to pinch and stretch UI components under development.
* Add/refine `CGContext`, `CGImage` and `UIImage` flat colour initialisers.
* Add `type` property to `Weak<Object>`.
* Add `<Optional>.forceUnwrappedInDEBUG(else:)` with associated infix operator `??!`.
* Add `<Sequence>.count(if:)`.

#### Deprecations
* Deprecate a number of overly specific UI types before moving them to `sky-app-ios/Toolkit`.
* Deprecated `CanLayout` protocol and all its dedicated conforming types.

