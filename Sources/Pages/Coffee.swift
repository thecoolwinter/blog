struct CoffeePage: Component {

    var body: some Component {
        Page(
            title: "Coffee",
            description: "My coffee explorations in Minneapolis",
            path: "coffee",
            loadCodeStyles: false,
            headContent: {
                // Inject the Apple Maps Script in the head tag
                Tag("script", ["src": "https://cdn.apple-mapkit.com/mk/5.x.x/mapkit.js"])
            }
        ) {

        }
    }
}
