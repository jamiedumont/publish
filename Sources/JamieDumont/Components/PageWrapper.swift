//
//  File.swift
//  
//
//  Created by Jamie Dumont on 20/05/2021.
//

import Plot

struct PageWrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider
    
    var body: Component {
        Div(content: content).class("centre")
    }
}
