struct Page<Content: Component, HeadContent: Component>: Component {
    let title: String
    let description: String
    let path: String
    let loadCodeStyles: Bool
    let content: () -> Content
    let headContent: () -> HeadContent

    init(
        title: String,
        description: String,
        path: String,
        loadCodeStyles: Bool,
        @HTMLBuilder headContent: @escaping () -> HeadContent,
        @HTMLBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.description = description
        self.path = path
        self.loadCodeStyles = loadCodeStyles
        self.content = content
        self.headContent = headContent
    }

    var body: some Component {
        Head(title: title, description: description, path: path, loadCodeStyles: loadCodeStyles)
        Tag("body") {
            Nav()
            Tag("div", ["class": "content"]) {
                content()
            }
            Footer()
        }
    }
}

extension Page where HeadContent == Never {
    init(
        title: String,
        description: String,
        path: String,
        loadCodeStyles: Bool,
        @HTMLBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.description = description
        self.path = path
        self.loadCodeStyles = loadCodeStyles
        self.content = content
        self.headContent = { fatalError() }
    }
}
