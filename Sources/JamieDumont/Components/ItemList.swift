//
//  File.swift
//  
//
//  Created by Jamie Dumont on 20/05/2021.
//

import Plot
import Publish

struct ItemList<Site: Website>: Component {
    var items: [Item<Site>]
    var site: Site
    
    var body: Component {
        List(items) { item in
            Article {
                H1(
                    ArrowLink(url: item.path, caption: item.title)
                ).class("post-preview__title")
                Paragraph(item.description)
                ItemTagList(item: item, site: site)
            }
            .class("post-preview")
        }
        .class("item-list")
        .attribute(named: "role", value: "list")
    }
}
