/**
*  Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Plot
import Publish

public extension Theme {
    /// The default "Foundation" theme that Publish ships with, a very
    /// basic theme mostly implemented for demonstration purposes.
    static var jamiedumont: Self {
        Theme(
            htmlFactory: JamieDumontHTMLFactory()
        )
    }
}



private struct JamieDumontHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .pageWrapper(
                    .icons(),
                    .header(for: context, selectedSection: nil),
                    .div(
                        .contentBody(index.body),
                        .h2("Recent posts"),
                        .itemList(
                            for: context.allItems(
                                sortedBy: \.date,
                                order: .descending
                            ),
                            on: context.site
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .pageWrapper(
                //.icons(),
                .header(for: context, selectedSection: section.id),
                .div(
                    .h1(.text(section.title)),
                    .itemList(for: section.items, on: context.site)
                ),
                .footer(for: context.site)
                    )
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .pageWrapper(
                    //.icons(),
                .header(for: context, selectedSection: item.sectionID),
                .div(
                    .article(
                        .div(
                            .contentBody(item.body)
                        ),
                        .span("Tagged with: "),
                        .tagList(for: item, on: context.site)
                    )
                ),
                .footer(for: context.site)
                    )
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .pageWrapper(
                   // .icons(),
                .header(for: context, selectedSection: nil),
                .div(.contentBody(page.body)),
                .footer(for: context.site)
                    )
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .pageWrapper(
                    //.icons(),
                    .header(for: context, selectedSection: nil),
                    .div(
                        .h1("Browse all tags"),
                        .ul(
                            .forEach(page.tags.sorted()) { tag in
                                .li(
                                    .class("tag"),
                                    .a(
                                        .href(context.site.path(for: tag)),
                                        .text(tag.string)
                                    )
                                )
                            }
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .pageWrapper(
                    //.icons(),
                .header(for: context, selectedSection: nil),
                .div(
                    .h1(
                        "Tagged with ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all tags"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
                    )
            )
        )
    }
}

private extension Node where Context == HTML.ListContext {
    static func role(_ roles: String) -> Self {
        .attribute(named: "role", value: roles)
    }
}

private extension Node where Context == HTML.AnchorContext {
    
}

private extension Node where Context == HTML.BodyContext {
    static func pageWrapper(_ nodes: Node...) -> Node {
        return .div(.class("centre"), .group(nodes))
    }
}

extension Node where Context: HTML.BodyContext {
    
//    static func icons() -> Node {
//        return .div(
//            .class("hidden"),
//            .svg(.attribute(named: "xmlns", value: "http://www.w3.org/2000/svg"),
//                 .arrowRight()
//            )
//            
//        )
//    }
//    
//    static func arrowRight() -> Node {
//        return .svg(.attribute(named: "viewBox", value: "0 0 141 110"),
//                    .attribute(named: "height", value: "1.2rem"),
//                       .path(
//                        .attribute(named: "d", value: "M85.5,0 C86.5700191,0 87.5615341,0.336115712 88.3747236,0.908525653 L88.4271465,0.856078708 L139.338835,51.767767 L139.325354,51.7800953 C140.058331,52.6499985 140.5,53.7734206 140.5,55 C140.5,56.909581 139.429512,58.5691361 137.855901,59.4112987 L89.9112987,107.355901 C89.0691361,108.929512 87.409581,110 85.5,110 C82.7385763,110 80.5,107.761424 80.5,105 C80.5,103.851287 80.8873723,102.793051 81.5386121,101.948794 L81.3560787,101.767767 L123.123,60 L6,60 L6.00070198,59.9752426 C5.83602154,59.9916165 5.66898981,60 5.5,60 C2.73857625,60 0.5,57.7614237 0.5,55 C0.5,52.2385763 2.73857625,50 5.5,50 C5.66898981,50 5.83602154,50.0083835 6.00070198,50.0247574 L6,50 L123.429,50 L81.3560787,7.92714652 L81.4085257,7.87472363 C80.8361157,7.0615341 80.5,6.07001907 80.5,5 C80.5,2.23857625 82.7385763,0 85.5,0 Z"),
//                        .attribute(named: "fill", value: "currentColor")
//                       )
//               )
//    }
    
    static func path(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "path", nodes: nodes)
    }
    
    static func svg(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "svg", nodes: nodes)
    }
    
    static func symbol(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "symbol", nodes: nodes)
    }
    
    static func g(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "g", nodes: nodes)
    }
    
    static func line(x1: String, y1: String, x2: String, y2: String, attributes: Attribute<HTML.BodyContext>...) -> Node {
        
        var lineAttributes: [Attribute<HTML.BodyContext>] = [
            .attribute(named: "x1", value: x1),
            .attribute(named: "y1", value: y1),
            .attribute(named: "x2", value: x2),
            .attribute(named: "y2", value: y2)
        ]
        lineAttributes.append(contentsOf: attributes)
        
        return .element(named: "line", attributes: lineAttributes)
        
    }
    

    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .div(
                .a(.class("site-name"), .href("/"), .text("Jamie Dumont")),
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(.a(
                                .class(section == selectedSection ? "selected" : ""),
                                .href(context.sections[section].path),
                                .text(context.sections[section].title)
                            ))
                        })
                    )
                )
            )
        )
    }

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .role("list"),
            .forEach(items) { item in
                .li(.article(
                    .class("post-preview"),
                    .h1(
                        .class("post-preview__title"),
                        .arrowLink(caption: item.title, dest: item.path)
                        ),
                    .p(.text(item.description)),
                    .tagList(for: item, on: site)
                ))
            }
        )
    }
    

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }
    
    

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
//            .p(
//                .text("Generated using "),
//                .a(
//                    .text("Publish"),
//                    .href("https://github.com/johnsundell/publish")
//                )
//            ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
            ))
        )
    }
}
