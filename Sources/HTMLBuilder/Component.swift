protocol Component {
    associatedtype Body: Component

    @HTMLBuilder
    var body: Self.Body { get }

    var html: String { get }
}

extension Component {
    var html: String { body.html }
}

extension Never: Component {
    var body: some Component { self }
    var html: String { "" }
}

struct EmptyComponent: Component {
    var body: some Component { fatalError() }
    var html: String { fatalError() }
}

struct TupleComponent: Component {
    init<each Content>(_ content: repeat each Content) where repeat each Content: Component {
        func buildHTML<T: Component>(_ item: T, html: inout String) {
            if T.self != EmptyComponent.self {
                html += item.html
            }
        }
        var value = ""
        repeat buildHTML(each content, html: &value)
        self.html = value
    }

    init(_ components: [any Component]) {
        self.html = components.filter { type(of: $0) != EmptyComponent.self }.map { $0.html }.joined()
    }

    var body: some Component {
        fatalError("")
    }

    var html: String
}
