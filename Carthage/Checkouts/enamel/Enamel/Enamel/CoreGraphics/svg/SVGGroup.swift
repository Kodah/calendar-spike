import CoreGraphics

public struct SVGGroup {
    
    public init<S>(_ nodes: S)
        where
        S: Sequence,
        S.Iterator.Element: SVG
    {
        self.nodes = nodes.map{ $0 as SVG }
    }
    
    public init<S>(_ nodes: S)
        where
        S: Sequence,
        S.Iterator.Element == SVG
    {
        self.nodes = Array(nodes)
    }
    
    public init<T: SVG>(_ nodes: T...) {
        self.nodes = nodes.map{ $0 as SVG }
    }
    
    public init(_ nodes: SVG...) {
        self.nodes = nodes
    }
    
    fileprivate var nodes: [SVG]
}

public extension SVG {
    public var group: SVGGroup { return self as? SVGGroup ?? SVGGroup(self) }
}

public extension Sequence where Iterator.Element: SVG {
    public var svg: SVGGroup { return self as? SVGGroup ?? SVGGroup(self) }
}

extension SVGGroup: SVG {
    public func add(to context: SVGContext) {
        nodes.forEach{ $0.add(to: context) }
    }
}

extension SVGGroup: RandomAccessCollection { 
    public func makeIterator() -> IndexingIterator<[SVG]> { return nodes.makeIterator() }
    public var startIndex: Int { return nodes.startIndex }
    public var endIndex: Int { return nodes.endIndex }
    public func index(after i: Int) -> Int { return nodes.index(after: i) }
    public func index(before i: Int) -> Int { return nodes.index(before: i) }
    public subscript(position: Int) -> SVG { return nodes[position] }
}

extension SVGGroup: RangeReplaceableCollection {
    
    public init() { nodes = [] }

    public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C)
        where
        C : Collection,
        C.Iterator.Element == SVG
    {
        nodes.replaceSubrange(subrange, with: newElements)
    }
}


