import Foundation
import RegexBuilder
import Ink

private let headingIdsModifier: Modifier = Modifier(target: .headings) { input in
    let pattern = Regex {
        One("<")
        One("h")
        Capture {
            One(.digit)
        }
        One(">")

        Capture() {
            OneOrMore(.any)
        }

        One("</h")
        One(.digit)
        One(">")
    }

    return input.html.replacing(pattern) { match in
        let tagId = match.output.2
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\n", with: "")
            .filter { $0.isLetter || $0.isNumber || $0.isWhitespace }
            .replacingOccurrences(of: " ", with: "-")
            .lowercased()

        return "<h\(match.output.1) id=\"\(tagId)\"><a href=\"#\(tagId)\" class=\"header-link\">\(match.output.2)</a></h\(match.output.1)>"
    }
}

struct BlogPostContents {
    // Points to the relative markdown file (index.md)
    let path: URL
    let markdown: Markdown
    let title: String
    let excerpt: String
    let tags: [String]
    let createdAt: Date
    let katex: Bool

    var linkPath: String {
        path.deletingLastPathComponent().relativePath
    }

    init(path: URL) throws {
        let contents = try String(contentsOf: path)
        let parsed = MarkdownParser(modifiers: [headingIdsModifier]).parse(contents)
        guard let title = parsed.metadata["title"] else {
            fatalError("No title in metadata")
        }
        guard let excerpt = parsed.metadata["excerpt"] else {
            fatalError("No excerpt in metadata")
        }
        guard let tags = parsed.metadata["tags"]?.split(separator: ", ") else {
            fatalError("No tags in metadata")
        }
        guard let createdAtRaw = parsed.metadata["created_at"] else {
            fatalError("No created_at metadata")
        }
        let createdAt = DateFormatter.parseSimple(string: createdAtRaw)

        self.path = path
        self.markdown = parsed
        self.title = title
        self.excerpt = excerpt
        self.tags = tags.map { String($0).trimmingCharacters(in: CharacterSet.alphanumerics.inverted) }.filter { !$0.isEmpty }
        self.createdAt = createdAt
        self.katex = parsed.metadata["katex"] != nil
    }
}
