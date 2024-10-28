import Foundation

struct Footer: Component {
    var body: some Component {
        Tag("footer") {
            P { "Copyright ©️ Khan Winter \(Date().year)" }
            P { "Built In Swift" }
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
