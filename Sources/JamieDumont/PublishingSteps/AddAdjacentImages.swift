//
//  File.swift
//  
//
//  Created by Jamie Dumont on 22/05/2021.
//

import Files
import Publish

extension Plugin {
    static func addAdjacentImages(_ path: Path = "Content") -> Self {
        Plugin(name: "Adds images from Content to Output") { context in
//            let items = context.allItems(sortedBy: \.date)
//            for item in items {
//                let itemPath = path.appendingComponent(item.path.string)
//                do {
//                    let itemFolder = try context.folder(at: itemPath)
//                    for file in itemFolder.files.recursive {
//
//                        guard file.isImage else { continue }
//
//                        var name = file.nameExcludingExtension
//                        var path = file.path
//                        print(item.path)
//                    }
//                } catch {
//                    continue
//                }
//
//
//
//                //item.this = "that"
//            }
            
            
            let contentRoot = try context.folder(at: path)
            for file in contentRoot.files.recursive {
                guard file.isImage else { continue }

                let relativePathStr = file.path(relativeTo: contentRoot)

                let imagePath = path.appendingComponent(relativePathStr)

                let parent = file.parent
                let parentRelativePath = Path(parent?.path(relativeTo: contentRoot) ?? "photos")

                try context.copyFileToOutput(from: imagePath, to: parentRelativePath)
            }
            
        }
    }
}

private extension File {
    private static let imageFileExtensions: Set<String> = [
        "jpg", "jpeg"
    ]

    var isImage: Bool {
        self.extension.map(File.imageFileExtensions.contains) ?? false
    }
}
