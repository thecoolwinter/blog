import Foundation

struct Footer: Component {
    var body: some Component {
        Tag("footer") {
            P { "Copyright ©️ Khan Winter \(Date().year)" }
            P { "Built In Swift" }
            P {
                A("https://twitter.com/thecoolwinter", ["rel": "me"]) { "Twitter" }
                " | "
                A("https://threads.net/thecoolwinter", ["rel": "me"]) { "Threads" }
                " | "
                A("") { "RSS" }
            }
        }
    }
}
