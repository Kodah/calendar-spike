//: ### Layout Example - NotificationView
//: - note: 🖥 Open the Timeline in the Assistant Editor to see the result.
import EnamelKit

class NotificationView: UIView {
    
    private(set) lazy var layout: CGLayout = self.divideLayout.snugged.padded(by: 16)
    
    private(set) lazy var divideLayout: CGDivideLayout = CGDivideLayout(
        from: .left,
        spacing: 16,
        slice: self.imageView.aspectFitting(square: 32, aligned: .top(.left)),
        remainder: CGStackLayout(
            aligning: .bottom(.left),
            children: self.titleLabel, self.messageLabel
        )
    )
    
    override func layoutSubviews() {
        layout.arrange(in: bounds)
    }
    
    override func size(toFit size: CGSize) -> CGSize {
        return size.with(height: layout.size(toFit: view.bounds.size).height)
    }
    
    override func arrange(in rect: CGRect) {
        frame = rect.with(size: size(toFit: rect.size))
    }
    
    private lazy var titleLabel: UILabel = {
        let o = UILabel(frame: .unit)
        o.font = UIFont.Sky.medium.font.withSize(22)
        o.text = "Sky Message"
        self.addSubview(o)
        return o
    }()
    
    private lazy var messageLabel: UILabel = {
        let o = UILabel(frame: .unit)
        o.font = UIFont.Sky.regular.font.withSize(16)
        o.allowWordWrapping()
        self.addSubview(o)
        return o
    }()
    
    private lazy var imageView: UIImageView = {
        let o = FittingImageView(frame: .unit)
        o.backgroundColor = .gray
        self.addSubview(o)
        return o
    }()
    
    init(text: String, image: UIImage) {
        super.init(frame: .unit)
        layer.backgroundColor = .pink
        messageLabel.text = text
        imageView.image = image
    }
    
    required init?(coder: NSCoder) { UNIMPLEMENTED }
    
    fileprivate class FittingImageView: UIImageView {
        
        override var contentMode: UIViewContentMode { get{ return .scaleAspectFit } set{} }
        
        // by default <UIImage>.sizeThatFits(_:) returns image.size
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            return image?.size.size(toFit: size) ?? .zero
        }
    }
}

let view = UIView(frame: CGRect(square: 320))

let notificationView = NotificationView(
    text: "You have a new message from the Sky Service Team",
    image: UIImage.with(width: 60, height: 40, color: .black)
)

notificationView.arrange(in: view.bounds)

view.addSubview(notificationView)
view.layer.backgroundColor = .olive

import PlaygroundSupport
PlaygroundPage.current.liveView = view










