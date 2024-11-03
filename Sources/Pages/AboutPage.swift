import Foundation
import Ink

struct AboutPage: Component {
    var body: some Component {
        Page(
            title: "About",
            description: "Hello 👋 My name's Khan Winter. I'm a Swift and Embedded Systems engineer with experience in iOS and macOS development.",
            path: "about",
            loadCodeStyles: false
        ) {
            Tag("article") {
                Tag("div", ["class": "home-header"]) {
                    Img(resourceName: "avatar-large.webp", alt: "Avatar", size: (128, 128))
                    P { "About Me" }
                }

                let years = abs(Date(timeIntervalSince1970: 1549432800.0).timeIntervalSinceNow / 3.15576e+7)
                MarkdownParser().html(from: """
                    Hello 👋 My name's Khan Winter. I'm a Swift and Embedded Systems engineer with over \(Int(years)) years of experience in iOS and macOS development.
                    
                    ## Open Source
                    
                    I co-lead and maintain the [CodeEdit](https://codeedit.app) project, an unapologetically macOS code editor. I've built out CodeEdits custom editor using CoreText and AppKit APIs, and have contributed to nearly every feature in the app. While working on this project I've gotten to meet some amazing people and hone my AppKit and Swift skills to a sharp edge. We don't yet have a v1.0, but are constantly working towards it.
                    
                    I've also built a few Swift example projects and doo-dads over on my [github](https://github.com/thecoolwinter).
                    
                    ## Education
                    
                    Bachelors of Computer Engineering, University of Minnesota Twin Cities - 2024
                    
                    ## Student Challenge
                    
                    In 2020 I was a winner of Apple's Swift Student Challenge competition. I submitted a small project demoing OOP skills in the form of a small game. The game is called [PaddleBreaker](https://paddlebreaker.windchillmedia.com/) and is a mashup of pong and breakout!
                    
                    ## OpenBudget
                    
                    I created [OpenBudget](https://openbudget.us/) to help handle my personal expenses while still in High School. Sadly, I haven't had the time to continue to update it. OpenBudget was a novel way of managing expenses, where each expense category was not related to a period of time. Rather, each bucket was a continuous balance that allowed users to keep healthy spending habits without a time limit of sorts that other programs push.
                    
                    OpenBudget experienced some success, with over 33,000 lifetime downloads and millions of app store impressions. OpenBudget was featured by Apple on the front page of the app store for a short time. I'm very proud of the work I was able to do on this project.
                    
                    During the course of building this app I gained skills in publishing, marketing, and programming apps for the Apple ecosystem. At it's peak, OpenBudget supported nearly every feature available to apps. Siri support, widgets, today extensions, and of course a beautifully designed iOS, macOS, watchOS, and iPadOS app. 
                    
                    ## FuelingTimer
                    
                    [FuelingTimer](https://www.fuelingtimer.app/) is the second somewhat successful app I've published on the App Store. Again, I've not had as much time as I'd like to put towards it. This app had about 10,000 lifetime downloads and gained popularity in a very niche dieting community. FuelingTimer allowed users to set a number of timers at predetermined intervals throughout the day and be reminded when those timers went off.
                    """
                )
            }
        }
    }
}
