import Foundation
import Publish
import Plot
//import JamieDumontPublishTheme

// This type acts as the configuration for your website.
struct JamieDumont: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://jamiedumont.co.uk")!
    var name = "Jamie Dumont"
    var description = "Web developer turned iOS dev"
    var language: Language { .english }
    var imagePath: Path? { nil }
    var titleSeparator = "-"
}

// This will generate your website using the built-in Foundation theme:
try JamieDumont().publish(withTheme: .jamiedumont)
