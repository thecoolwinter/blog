struct PhoneVideoEmbed: Component {
    let src: String
    let speed: String?

    private var isSlow: Bool { speed == "0.5" }

    var body: some Component {
        Tag("div", ["class": "phone-embed"]) {
            Tag("div", ["class": "phone-embed__content"]) {
                Tag("div", ["class": "phone-embed__controls"]) {
                    Tag(
                        "button",
                        [
                            "type": "button",
                            "class": "phone-speed",
                            "data-speed": speed ?? "1"
                        ]
                    ) {
                        Tag("span", ["data-active": isSlow ? "false" : "true"]) { "1x" }
                        Tag("span", ["data-active": isSlow ? "true" : "false"]) { "0.5x" }
                    }
                }

                Tag("div", ["class": "phone"]) {
                    Tag(
                        "img",
                        [
                            "class": "phone__bezel",
                            "src": "/assets/iphone-16-bezel.png",
                            "width": "675",
                            "height": "1380",
                            "alt": ""
                        ]
                    ) { EmptyComponent() }

                    Tag("div", ["class": "phone__screen"]) {
                        Tag(
                            "video",
                            [
                                "src": src,
                                "autoplay": "",
                                "muted": "",
                                "loop": "",
                                "playsinline": "",
                                "preload": "metadata"
                            ]
                        ) { EmptyComponent() }
                    }
                }
            }
        }
    }
}
