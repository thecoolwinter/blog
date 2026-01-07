@resultBuilder
enum HTMLBuilder {
    static func buildBlock<each Content>(_ content: repeat each Content) -> TupleComponent where repeat each Content: Component {
        TupleComponent(repeat each content)
    }

    static func buildOptional(_ component: TupleComponent?) -> TupleComponent {
        if let component {
            component
        } else {
            TupleComponent([EmptyComponent()])
        }
    }

    static func buildEither<Content: Component>(first component: Content) -> Content {
        component
    }

    static func buildEither<Content: Component>(second component: Content) -> Content {
        component
    }

    static func buildArray(_ components: [any Component]) -> TupleComponent {
        TupleComponent(components)
    }
}

enum HTMLRenderer {
    static func render<Content: Component>(@HTMLBuilder page: () -> Content) -> String {
        "<!DOCTYPE html><html lang=\"en\" data-theme=\"light\">" + page().html + "</html>"
    }
}

enum ATOMRenderer {
    static func render<Content: Component>(@HTMLBuilder page: () -> Content) -> String {
        #"<?xml version="1.0" encoding="utf-8"?><feed xmlns="http://www.w3.org/2005/Atom">"#
        + page().html
        + "</feed>"
    }
}
