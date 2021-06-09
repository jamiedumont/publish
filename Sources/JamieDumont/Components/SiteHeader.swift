//
//  File.swift
//  
//
//  Created by Jamie Dumont on 20/05/2021.
//

import Plot
import Publish

struct SiteHeader<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSectionID: Site.SectionID?
    
    var body: Component {
        Header {
            Link(context.site.name, url: "/").class("site-name")
            
            if Site.SectionID.allCases.count > 1 {
                navigation
            }
        }.class("site-header")
    }
    
    private var navigation: Component {
        Navigation {
            List(Site.SectionID.allCases) { sectionID in
                let section = context.sections[sectionID]
                
                return Link(section.title,
                            url: section.path.absoluteString
                ).class(sectionID == selectedSectionID ? "selected" : "")
            }
        }.class("site-navigation")
    }
}
