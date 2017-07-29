/*:
 # Enamel
 A coat of gloss that makes a hard and beautiful thing even more beautiful and harder to break.
 */
import Enamel
 
let frame = CGRect(square: 20)
let outer = frame.tiled(rows: 2, cols: 2, padding: 3, spacing: 3)
let inner = try outer.last.unwrap().grid(rows: 2, cols: 2, padding: 3, spacing: 3)
outer + inner // 🖥 show result
/*:
 - [Aligning Rects](Aligning%20Rects)
 - [Attributed Strings](Attributed%20Strings)
 - [CGLayout](CGLayout)
 - [Debug](Debug)
 - [Dictionary+branch](Dictionary+branch)
 - [Dispatch](Dispatch)
 - [Files](Files)
 - [HasID](HasID)
 - [QuartzCore](QuartzCore)
 - [Random](Random)
 - [Regular Expressions](Regular%20Expressions)
 - [SelflessEquatable](SelflessEquatable)
 - [Sequences](Sequences)
 - [Serialization](Serialization)
 - [Standard Library](Standard%20Library)
 - [SVG](SVG)
 - [SVGContext](SVGContext)
 - [VersionNumber](VersionNumber)

 [Next](@next)
*/

