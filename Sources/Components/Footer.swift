import Foundation

struct Footer: Component {
    var body: some Component {
        Tag("footer") {
            P { "Copyright &copy; Khan Winter \(Date().year)" }
            P { A("https://github.com/thecoolwinter/blog") { "Built In Swift" } }
            P {
                A("https://twitter.com/thecoolwinter", ["rel": "me", "target": "_blank"]) { "Twitter" }
                " | "
                A("https://threads.net/thecoolwinter", ["rel": "me", "target": "_blank"]) { "Threads" }
                " | "
                A("") { "RSS" }
            }
        }
    }
}
