struct Img: Component {
    let resourceName: String
    let alt: String
    let size: (width: Int, height: Int)

    var body: some Component {
        Tag("img", ["src": "/assets/" + resourceName, "width": "\(size.width)", "height": "\(size.height)", "alt": alt]) {
            EmptyComponent()
        }
    }
}
