//: ### Layout Example - Disclosable Items
//: - note: 🖥 Open the Timeline in the Assistant Editor to see the result.
import EnamelKit

extension Notification.Name {
    static let itemSelectedStateDidChange = Notification.Name("itemSelectedStateDidChange")
}

class Item: UIControl {
    
    struct Model {
        let title: String
        let message: String
    }
    
    let model: Model
    
    override var isSelected: Bool {
        didSet {
            NotificationCenter.default.post(name: .itemSelectedStateDidChange, object: self)
        }
    }
    
    private lazy var title: UILabel = UILabel(self.model.title.with(Item.titleStyle)).wrappable
    private lazy var message: UILabel = UILabel(self.model.message.with(Item.messageStyle)).wrappable
    
    private var layout: CGLayout {
        return (isSelected ? selectedLayout : unselectedLayout)
            .padded(by: 10)
    }
    
    private lazy var unselectedLayout: CGLayout = self.title
        .aligned(.center)
    
    private lazy var selectedLayout: CGLayout = CGStackLayout(
        aligning: .bottom(.center),
        children: self.title, self.message
    )
    
    init(_ model: Model) {
        self.model = model
        super.init(frame: .unit)
        with(layer) { o in
            o.masksToBounds = true
            o.borderColor = .white
            o.borderWidth = 1
            o.cornerRadius = 4
        }
        addSubviews(title, message)
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    required init?(coder: NSCoder) { UNIMPLEMENTED }
    
    @objc private func didTap() {
        isSelected.toggle()
    }
    
    override func layoutSubviews() {
        layout.arrange(in: bounds)
    }
    
    override func size(toFit size: CGSize) -> CGSize {
        return layout.size(toFit: size)
    }
    
    override func arrange(in rect: CGRect) {
        super.arrange(in: rect)
        message.alpha = isSelected ? 1 : 0
    }
}

extension Item {
    static let style: [NSStringAttribute] = [.color(UIColor.white)]
    static let titleStyle = style.with(Sky.font.medium)
    static let messageStyle = style.with(Sky.font.regular)
}

class View: UIScrollView {
    
    private lazy var layout: CGLayout = self.stackLayout.padded(by: 20)
    
    private lazy var stackLayout: CGStackLayout = CGStackLayout(
        spacing: 10,
        aligning: .bottom(.center),
        children: self.items
    )
    
    private lazy var data = (1...17).map { i in
        Item.Model(
            title: "Item No. \(i) Title!",
            message: "A rather long message that most likely wrapps over multiple lines..."
        )
    }
    
    private lazy var items: [Item] = self.data.map(Item.init)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.backgroundColor = .skyBlue
        addSubviews(items)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(itemSelectionStateDidChange),
            name: .itemSelectedStateDidChange,
            object: nil
        )
    }
    required init?(coder aDecoder: NSCoder) { UNIMPLEMENTED }
    
    @objc private func itemSelectionStateDidChange(notification: Notification) {
        guard notification.object is Item else { return }
        animate()
    }
    
    fileprivate func animate() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        contentSize = layout.size(toFit: bounds.size)
        layout.arrange(in: contentSize.rect())
    }
}

import PlaygroundSupport
let view = View(frame: CGRect(width: 320, height: 480))
PlaygroundPage.current.liveView = view





