struct Page<Content: Component>: Component {
    let title: String
    let description: String
    let path: String
    let loadCodeStyles: Bool
    let content: () -> Content

    init(title: String, description: String, path: String, loadCodeStyles: Bool, @HTMLBuilder content: @escaping () -> Content) {
        self.title = title
        self.description = description
        self.path = path
        self.loadCodeStyles = loadCodeStyles
        self.content = content
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
