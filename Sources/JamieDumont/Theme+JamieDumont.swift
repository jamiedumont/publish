/**
*  Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Plot
import Publish

public extension Theme {
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
            .body {
                PageWrapper {
                    SiteHeader(context: context, selectedSectionID: nil)
                    Paragraph(index.body)
                    Div {
                        H2("Recent Posts")
                        ItemList(
                            items: context.allItems(
                                sortedBy: \.date,
                                order: .descending
                            ),
                            site: context.site
                        )
                    }
                    SiteFooter()
                }
            }
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body {
                PageWrapper {
                    SiteHeader(context: context, selectedSectionID: section.id)
                    
                    Div {
                        H2(section.title)
                        ItemList(
                            items: section.items,
                            site: context.site
                        )
                    }
                    SiteFooter()
                }
            }
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body {
                PageWrapper {
                    SiteHeader(context: context, selectedSectionID: item.sectionID)
                    
                    Article {
                        Div(item.content.body)
                        Span("Tagged with:")
                        ItemTagList(item: item, site: context.site)
                    }
                        
                    SiteFooter()
                }
            }
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                PageWrapper {
                    SiteHeader(context: context, selectedSectionID: nil)
                    SiteFooter()
                }
            }
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                PageWrapper {
                    SiteHeader(context: context, selectedSectionID: nil)
                    H1("Browse all tags")
                    List(page.tags.sorted()) { tag in
                        ListItem {
                            Link(tag.string,
                                 url: context.site.path(for: tag).absoluteString
                            )
                        }
                        .class("tag")
                    }
                    .class("all-tags")
                    
                    SiteFooter()
                }
            }
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                PageWrapper {
                    SiteHeader(context: context, selectedSectionID: nil)
                    H1 {
                        Text("Tagged with ")
                        Span(page.tag.string).class("tag")
                    }

                    Link("Browse all tags",
                        url: context.site.tagListPath.absoluteString
                    )
                    .class("browse-all")

                    ItemList(
                        items: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        site: context.site
                    )
                    SiteFooter()
                }
            }
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

extension Node where Context: HTML.BodyContext {
    
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
    

}
