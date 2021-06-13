import Foundation
import Files
import Publish
import Plot
import Ink
import VerifyResourcesExistPublishPlugin
import LocalWebsitePublishPlugin
//import MagickPublishPlugin
//import JamieDumontPublishTheme

struct PhotoOption {
    var width: Int
    var format: String
}

// This type acts as the configuration for your website.
struct JamieDumont: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
        case photos
    }
    
    struct PhotoInfo : WebsiteItemMetadata {
        var dateTaken: Date?
        var location: String?
        var caption: String?
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
        var photo: PhotoInfo?
//        var photos: [Photo]?
    }
    
    

    // Update these properties to configure your website:
    var url = URL(string: "https://www.jamiedumont.co.uk")!
    var name = "Jamie Dumont"
    var description = "Web developer turned iOS dev"
    var language: Language { .ukEnglish }
    var imagePath: Path? { nil }
    var titleSeparator = "-"
}

// This will generate your website using the built-in Foundation theme:
try JamieDumont().publish(using: [
    .addMarkdownFiles(),
//    .installPlugin(.addPageBundles()),
    .copyResources(),
    .installPlugin(.addAdjacentImages()),
//    .installPlugin(.optimisePhotos(path: "Resources/Photos", options : [
//        PhotoOption(width: 400, format: "jpeg"),
//        PhotoOption(width: 800, format: "jpeg")
//    ])),
    //.installPlugin(.optimizeForWeb(imagesInFolder: "Output/Photos/")),
    
//    .installPlugin(.plotPage()),
    .generateHTML(withTheme: .jamiedumont),
    .installPlugin(.localifyHTML()),
    //.installPlugin(.verifyResourcesExist()),
    .generateRSSFeed(including: [.photos, .posts]),
    .generateSiteMap()
])

//private extension PageBundle
//
//struct PageBundler<Site: Website> {
//    func from(_ folder: Folder,
//              to context: inout PublishingContext<Site>
//    ) throws {
//        if let indexFile = try? folder.file(named: "index.md") {
//            do {
//                /// Add content for site index
//                //context.index.content = try factory.makeContent(fromFile: indexFile)
//            } catch {
//                throw wrap(error, forPath: "\(folder.path)index.md")
//            }
//        }
//
//        for subfolder in folder.subfolders {
//            guard let sectionID = Site.SectionID(rawValue: subfolder.name.lowercased()) else {
//                try addPagesForMarkdownFiles(
//                    inFolder: subfolder,
//                    to: &context,
//                    recursively: true,
//                    parentPath: Path(subfolder.name),
//                    factory: factory
//                )
//
//                continue
//            }
//
//            for file in subfolder.files.recursive {
//                guard file.isMarkdown else { continue }
//
//                if file.nameExcludingExtension == "index", file.parent == subfolder {
//                    let content = try factory.makeContent(fromFile: file)
//                    context.sections[sectionID].content = content
//                    continue
//                }
//
//                do {
//                    let fileName = file.nameExcludingExtension
//                    let path: Path
//
//                    if let parentPath = file.parent?.path(relativeTo: subfolder) {
//                        path = Path(parentPath).appendingComponent(fileName)
//                    } else {
//                        path = Path(fileName)
//                    }
//
//                    let item = try factory.makeItem(
//                        fromFile: file,
//                        at: path,
//                        sectionID: sectionID
//                    )
//
//                    context.addItem(item)
//                } catch {
//                    let path = Path(file.path(relativeTo: folder))
//                    throw wrap(error, forPath: path)
//                }
//            }
//        }
//
//        try addPagesForMarkdownFiles(
//            inFolder: folder,
//            to: &context,
//            recursively: false,
//            parentPath: "",
//            factory: factory
//        )
//    }
//}

public extension Plugin {
//    static func addPageBundles(path: Path = "Content") -> Self {
//        Plugin(name: "Add Page Bundles") { context in
//            let folder = try context.folder(at: path)
//            try PageBundler().from(folder, to: &context)
//        }
//    }
    
    internal static func optimisePhotos(path: Path = "Resources/Photos", options: [PhotoOption]) -> Self {
        Plugin(name: "Optimise Photos") { context in
            let contentRoot = try context.folder(at: path)
            for file in contentRoot.files.recursive {
                guard file.isImage else { continue }
                let fileName = file.nameExcludingExtension
                guard let parentPath = file.parent?.path else { continue }
                let undscr = "_"
                let dot = "."
                
                for version in options {
                    var possibleVersionPathString: String = parentPath + fileName + undscr + String(version.width) + dot + version.format
                    //var possibleVersionPath = parentPath + fileName + "_" + version.width + "." + version.format
                    
                    let possibleVersion = try File(path: possibleVersionPathString)
                    print(possibleVersion.name)
                }
            }
        }
    }
    
    static func markdownEdit() -> Self {
        Plugin(name: "Markdown Edit") { context in
            context.markdownParser.addModifier(.markdownEdit())
        }
    }
    
    static func plotPage() -> Self {
        Plugin(name: "Plot page") { context in
            let rootFolder = try context.folder(at: "Content")
            
            for file in rootFolder.files.recursive {
                guard file.isPlot else { continue }
                let parent = file.parent
                let parentPath = Path((parent?.path(relativeTo: rootFolder))!)
                let pagePath = parentPath.appendingComponent(file.nameExcludingExtension)
                print(file.nameExcludingExtension)
                
                //let body: Component = try file.readAsString()
                let body = Article { H1("Test") }
                
                
                
//                func body() -> Component {
//                    return Article {
//                        H1("Test")
//                    }
//                }
                
                
                let page = Page(
                    path: pagePath,
                    content: Content(
                        title: "Plot page",
                        body: Content.Body() { body }
                    )
                )
                context.addPage(page)
            }
            
        }
    }
}

private extension File {
    private static let plotFileExtensions: Set<String> = [
        "plot"
    ]
    
    private static let htmlFileExtensions: Set<String> = [
        "html"
    ]

    var isPlot: Bool {
        self.extension.map(File.plotFileExtensions.contains) ?? false
    }
    var isHTML: Bool {
        self.extension.map(File.htmlFileExtensions.contains) ?? false
    }
}

public extension Modifier {
    static func markdownEdit() -> Self {
        return Modifier(target: .images) { html, markdown in
            return "<img src='#'></img>"
        }
    }
}
