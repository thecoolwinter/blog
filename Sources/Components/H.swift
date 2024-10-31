struct H<Content: Component>: Component {
    let level: Int
    let content: () -> Content

    init(_ level: Int, @HTMLBuilder content: @escaping () -> Content) {
        assert((1...6).contains(level), "Invalid H Tag Level")
        self.level = level
        self.content = content
    }

    var body: some Component { content() }
    var html: String {
        "<h\(level)>" + content().html + "</h\(level)>"
    }
}
