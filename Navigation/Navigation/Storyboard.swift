//
//  Storyboard.swift
//  Navigation
//
//  Created by Drouin on 09/04/2019.
//  Copyright © 2019 VersusMind. All rights reserved.
//

import Foundation

class Storyboard {
    var fileName: String!
    var entryPoint: String!
    
    var externalReferenceName: [(key: String, id: String)]!
    var arrayController: [(name: String, id: String)]!
    
    init(fileName: String, entryPoint: String, arrayController: [(name: String, id: String)], externalReferenceName: [(key: String, id: String)]) {
        self.fileName = fileName
        self.entryPoint = entryPoint
        self.arrayController = arrayController
        self.externalReferenceName = externalReferenceName
    }
}
