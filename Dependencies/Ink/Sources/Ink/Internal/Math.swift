internal struct InlineMath: Fragment {
    let raw: Substring

    static func read(using reader: inout Reader) throws -> InlineMath {
        let count = reader.readCount(of: "$")
        try require(count == 1 || count == 2)
        let content = try reader.read(until: "$", required: true, allowWhitespace: true, allowLineBreaks: true)
        if count == 2 {
            try reader.read("$")
        }
        return InlineMath(raw: content)
    }

    var modifierTarget: Modifier.Target { .inlineMath }

    func html(usingURLs urls: NamedURLCollection, modifiers: ModifierCollection) -> String {
        "<span class=\"math-inline\">$\(raw)$</span>"
    }

    func plainText() -> String {
        String(raw)
    }
}


internal struct MathBlock: Fragment {
    let raw: Substring

    static func read(using reader: inout Reader) throws -> MathBlock {
        let startingMarkerCount = reader.readCount(of: "$")
        try require(startingMarkerCount == 2)
        let content = try reader.read(until: "$", required: true, allowWhitespace: true, allowLineBreaks: true)
        try reader.read("$")

        return MathBlock(raw: content)
    }

    var modifierTarget: Modifier.Target { .mathBlock }

    func html(usingURLs urls: NamedURLCollection, modifiers: ModifierCollection) -> String {
        "<span class=\"math-block\">$$\(raw)$$</span>"
    }

    func plainText() -> String {
        String(raw)
    }
}
