import Foundation
import Ink

struct BlogPostContents {
    let path: String
    let markdown: Markdown
    let title: String
    let excerpt: String
    let tags: [String]
    let createdAt: Date
    let katex: Bool

    init(path: String) throws {
        let contents = try String(contentsOfFile: path)
        let parsed = MarkdownParser().parse(contents)
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
