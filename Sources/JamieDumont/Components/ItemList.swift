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
            Div {
                
                if item.sectionID.rawValue == "posts" {
                    PostPreview(item: item, site: site)
                }
                
                if item.sectionID.rawValue == "photos" {
                    PhotoPreview(item: item, site: site)
                }
            
//            Article {
//                H1(
//                    ArrowLink(url: item.path, caption: item.title)
//                ).class("post-preview__title")
//                Paragraph(item.description)
//                ItemTagList(item: item, site: site)
//            }
//            .class("post-preview")
            }
        }
        .class("item-list")
        .attribute(named: "role", value: "list")
    }
}
