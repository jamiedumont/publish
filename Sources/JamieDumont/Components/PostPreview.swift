//
//  File.swift
//  
//
//  Created by Jamie Dumont on 11/05/2021.
//

import Plot
import Publish

struct PostPreview<Site: Website>: Component {
    var item: Item<Site>
    var site: Site
    
    var body: Component {
        Article {
            H2(
                ArrowLink(url: item.path, caption: item.title)
            ).class("post-preview__title")
            Paragraph(item.description)
            ItemTagList(item: item, site: site)
        }
        .class("post-preview")
    }
}
