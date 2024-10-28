struct Page<Content: Component>: Component {
    let loadCodeStyles: Bool
    let content: () -> Content

    init(loadCodeStyles: Bool, @HTMLBuilder content: @escaping () -> Content) {
        self.loadCodeStyles = loadCodeStyles
        self.content = content
    }

    var body: some Component {
        Head(loadCodeStyles: loadCodeStyles)
        Tag("body") {
            Tag("div", ["class": "content"]) {
                content()
            }
            Footer()
        }
    }
}
