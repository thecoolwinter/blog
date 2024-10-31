struct A<Content: Component>: Component {
    let url: String
    let attributes: [String: String]
    let content: () -> Content

    init(
        _ url: String,
        _ attributes: [String: String] = [:],
        @HTMLBuilder content: @escaping () -> Content
    ) {
        self.url = url
        self.attributes = attributes.merging(["href": url], uniquingKeysWith: { _, new in new })
        self.content = content
    }

    var body: some Component {
        content()
    }

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

        return "<a\(attributesString)>" + content().html + "</a>"
    }
}
