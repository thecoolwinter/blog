struct Meta: Component {
    let name: String
    let content: String

    init(_ name: String, _ content: String) {
        self.name = name
        self.content = content
    }

    var body: some Component {
        Tag("meta", ["name": name, "content": content]) {
            EmptyComponent()
        }
    }
}

struct MetaProperty: Component {
    let name: String
    let content: String

    init(_ name: String, _ content: String) {
        self.name = name
        self.content = content
    }

    var body: some Component {
        Tag("meta", ["property": name, "content": content]) {
            EmptyComponent()
        }
    }
}
