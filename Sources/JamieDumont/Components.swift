//
//  File.swift
//  
//
//  Created by Jamie Dumont on 30/12/2020.
//

import Plot
import Publish

extension Node where Context: HTML.BodyContext {
    
    static func arrowLink(caption: String, dest: Path) -> Node {
        return .a(
            .class("arrow-link"),
            .href(dest),
            .span(.text(caption)),
            .arrowRight()
        )
    }
    
    static func icons() -> Node {
        return .div(
            .class("hidden"),
            .svg(.attribute(named: "xmlns", value: "http://www.w3.org/2000/svg"),
                 .arrowRight()
            )
            
        )
    }
    
    static func arrowRight() -> Node {
        return .svg(.attribute(named: "viewBox", value: "0 0 141 110"),
                    .attribute(named: "height", value: "1rem"),
                       .path(
                        .attribute(named: "d", value: "M85.5,0 C86.5700191,0 87.5615341,0.336115712 88.3747236,0.908525653 L88.4271465,0.856078708 L139.338835,51.767767 L139.325354,51.7800953 C140.058331,52.6499985 140.5,53.7734206 140.5,55 C140.5,56.909581 139.429512,58.5691361 137.855901,59.4112987 L89.9112987,107.355901 C89.0691361,108.929512 87.409581,110 85.5,110 C82.7385763,110 80.5,107.761424 80.5,105 C80.5,103.851287 80.8873723,102.793051 81.5386121,101.948794 L81.3560787,101.767767 L123.123,60 L6,60 L6.00070198,59.9752426 C5.83602154,59.9916165 5.66898981,60 5.5,60 C2.73857625,60 0.5,57.7614237 0.5,55 C0.5,52.2385763 2.73857625,50 5.5,50 C5.66898981,50 5.83602154,50.0083835 6.00070198,50.0247574 L6,50 L123.429,50 L81.3560787,7.92714652 L81.4085257,7.87472363 C80.8361157,7.0615341 80.5,6.07001907 80.5,5 C80.5,2.23857625 82.7385763,0 85.5,0 Z"),
                        .attribute(named: "fill", value: "currentColor")
                       )
               )
    }
}
