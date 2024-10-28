import Foundation
import Ink

extension DateFormatter {
    static func parseSimple(string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: string)
        if let date {
            return date
        } else {
            fatalError("Couldn't parse string: \"\(string)\"")
        }
    }
}

struct Post: Component {
    let contents: String
    let parsed: Ink.Markdown
    let title: String
    let tags: [String]
    let createdAt: Date

    init(path: String) {
        do {
            self.contents = try String(contentsOfFile: path)
            let parsed = MarkdownParser().parse(contents)
            guard let title = parsed.metadata["title"] else {
                fatalError("No title in metadata")
            }
            guard let tags = parsed.metadata["tags"]?.split(separator: ", ") else {
                fatalError("No tags in metadata")
            }
            guard let createdAtRaw = parsed.metadata["created_at"] else {
                fatalError("No created_at metadata")
            }
            let createdAt = DateFormatter.parseSimple(string: createdAtRaw)

            self.parsed = parsed
            self.title = title
            self.tags = tags.map { String($0).trimmingCharacters(in: CharacterSet.alphanumerics.inverted) }
            self.createdAt = createdAt
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    var body: some Component {
        Tag("article") {
            if parsed.metadata["katex"] != nil {
                // Only load Katex on pages that need it.
                Tag(
                    "link",
                    [
                        "rel": "stylesheet",
                        "href": "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css",
                        "integrity": "sha384-nB0miv6/jRmo5UMMR1wu3Gz6NLsoTkbqJghGIsx//Rlm+ZU03BU6SQNC66uf4l5+",
                        "crossorigin": "anonymous"
                    ]
                ) { EmptyComponent() }
                Tag(
                    "script",
                    [
                        "defer": "",
                        "src": "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js",
                        "integrity": "sha384-7zkQWkzuo3B5mTepMUcHkMB5jZaolc2xDwL6VFqjFALcbeS9Ggm/Yr2r3Dy4lfFg",
                        "crossorigin": "anonymous"
                    ]
                ) { EmptyComponent() }
            }

            parsed.html
        }
    }
}
