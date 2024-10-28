struct P<Content: Component>: Component {
    let content: () -> Content

    init(@HTMLBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some Component { content() }
    var html: String {
        "<p>" + content().html + "</p>"
    }
}
