//
//  File.swift
//  
//
//  Created by Jamie Dumont on 20/05/2021.
//

import Plot

struct SiteFooter: Component {
    var body: Component {
        Footer {
            Paragraph {
                Link("RSS feed", url: "/feed.rss")
            }
        }
    }
}
