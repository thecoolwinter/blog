import Foundation

private let voidElements = [
    "<area>",
    "<base>",
    "<br>",
    "<col>",
    "<embed>",
    "<hr>",
    "<img>",
    "<input>",
    "<link>",
    "<meta>",
    "<param>",
    "<source>",
    "<track>",
    "<wbr>"
]

struct Tag<Content: Component>: Component {
    let name: String
    let attributes: [String: String]
    let content: () -> Content

    init(_ name: String, _ attributes: [String: String] = [:], @HTMLBuilder content: @escaping () -> Content) {
        self.name = name
        self.attributes = attributes
        self.content = content
    }

    init(_ name: String, _ attributes: [String: String] = [:]) where Content == EmptyComponent {
        self.name = name
        self.attributes = attributes
        self.content = { EmptyComponent() }
    }

    var body: some Component { content() }

    var html: String {
        var attributesString = attributes.sorted(by: { $0.key < $1.key })
            .map({ key, value in
                if value.isEmpty {
                    return key
                } else {
                    return key + "=\"" + value + "\""
                }
            })
            .joined(separator: " ")

        if !attributes.isEmpty {
            attributesString.insert(" ", at: attributesString.startIndex)
        }

        if Content.self == EmptyComponent.self || voidElements.contains(name) {
            return "<\(name)\(attributesString)/>"
        } else {
            return "<\(name)\(attributesString)>\(content().html)</\(name)>"
        }
    }
}
