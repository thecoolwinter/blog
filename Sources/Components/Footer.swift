import Foundation

struct Footer: Component {
    var body: some Component {
        Tag("footer") {
            P { "Copyright &copy Khan Winter \(Date().year)" }
            P { A("https://github.com/thecoolwinter/blog") { "Built In Swift" } }
            P {
                A("https://bsky.app/profile/khanwinter.com", ["rel": "me", "target": "_blank"]) { "Bluesky" }
                " | "
                A("https://khanwinter.com/feed.rss") { "RSS" }
            }
        }
    }
}
