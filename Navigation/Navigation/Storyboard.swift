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
    
    var dictionnaryController: [(name: String, id: String)]!
    
    init(fileName: String, entryPoint: String, dictionnaryController: [(name: String, id: String)]) {
        self.fileName = fileName
        self.entryPoint = entryPoint
        self.dictionnaryController = dictionnaryController
    }
}
