//
//  File.swift
//  
//
//  Created by Jamie Dumont on 11/05/2021.
//

import Plot
import Publish
import Foundation

struct PostPreview<Site: Website>: Component {
    let item: Item<Site>
    let site: Site
    let dateFormatter: DateFormatter
    let dateString: String
    
    init(item: Item<Site>, site: Site) {
        self.item = item
        self.site = site
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateString = dateFormatter.string(from: item.date)
    }

    var body: Component {
        Article {
            H2(
                ArrowLink(url: item.path, caption: item.title)
            ).class("post-preview__title")
            Paragraph(item.description)
            H6(dateString).class("post-preview__date")
            ItemTagList(item: item, site: site)
        }
        .class("post-preview")
    }
}
