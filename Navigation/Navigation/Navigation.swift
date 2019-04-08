//
//  Navigation.swift
//  Navigation
//
//  Created by Drouin on 02/04/2019.
//  Copyright © 2019 VersusMind. All rights reserved.
//

import UIKit

// Alias
public let Navigation = NavigationSingleton.instance

public class NavigationSingleton {
    internal static let instance = NavigationSingleton()
    
    // Dictionary <Storyboard name, [ViewController name]>
    private var dictionnary: Dictionary<String, [String]>!
    
    private init() {
        dictionnary =  getAllStoryboard()
    }
    
    private func getAllStoryboard() -> Dictionary<String, [String]> {
        var dictionnary = Dictionary<String, [String]>()
        var arrayName = [String]()
        if let directory = Bundle.main.resourcePath {
            // Storyboard file is in Base.lproj
            let allResources = try! FileManager.default.contentsOfDirectory(atPath: directory)
            // Filtered and add storyboard file
            arrayName.append(contentsOf: allResources.filter({ $0.hasSuffix(".storyboardc" )}))
            for name in arrayName {
                let shortName = name.split(separator: ".")[0] // cut extension
                dictionnary.updateValue(getAllController(namesStoryBoard: "\(directory)/\(name)"), forKey: String(shortName))
            }
            
            
            arrayName = [String]()
            let lprojs = allResources.filter({ $0.hasSuffix(".lproj" )})
            for lproj in lprojs {
                let allResources = try! FileManager.default.contentsOfDirectory(atPath: "\(directory)/\(lproj)")
                // Filtered and add storyboard file
                arrayName.append(contentsOf: allResources.filter({ $0.hasSuffix(".storyboardc" )}))
                for name in arrayName {
                    let shortName = name.split(separator: ".")[0]
                    dictionnary.updateValue(getAllController(namesStoryBoard: "\(directory)/\(lproj)/\(name)"), forKey: String(shortName))
                }
            }
        }
        return dictionnary
    }
    
    // Find all Storyboard in projet and all ViewController in Storyboatd
    // Return : Dictionary <"Storyboard name", ["ViewController name"]>
    private func getAllController(namesStoryBoard: String) -> [String] {
        var arrayControllerName = [String]()
        
        let directory = "\(namesStoryBoard)"
        if let directory =  URL(string: directory) {
            
            guard let files = try? FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles) else {
                return [String]()
            }
            
            // Filtered nib file (return ViewController and View)
            let filteredFiles = files.filter({ $0.pathExtension == "nib"})
            
            // nib file with not contain -view-
            for file in filteredFiles where !file.absoluteString.contains("-view-") {
                var fileController = file
                fileController.deletePathExtension()
                arrayControllerName.append(fileController.lastPathComponent)
            }
        }
        
        return arrayControllerName
    }
    
    // Return true if dictionnary contain controller Name
    func controllerExist(_ name: String) -> Bool {
        for dic in dictionnary {
            for controllerName in dic.value where controllerName == name {
                return true
            }
        }
        return false
    }
    
    func getViewController(_ name: String) -> UIViewController? {
        for dic in dictionnary {
            for controllerName in dic.value where controllerName == name {
                let storyboard = UIStoryboard(name: dic.key, bundle: nil)
                return storyboard.instantiateViewController(withIdentifier: controllerName)
            }
        }
        return nil
    }
    
    func getAllStoryboardName() -> [String] {
        var arrayNames = [String]()
        for dic in dictionnary {
            arrayNames.append(dic.key)
        }
        return arrayNames
    }
    
    
    func getAllViewControllerName() -> [String] {
        var arrayNames = [String]()
        for dic in dictionnary {
            for controllerName in dic.value {
                arrayNames.append(controllerName)
            }
        }
        return arrayNames
    }
 
    func getAllViewController(inStoryboard name: String) -> [String] {
        var arrayNames = [String]()
        for dic in dictionnary where dic.key == name {
            for controllerName in dic.value {
                arrayNames.append(controllerName)
            }
        }
        return arrayNames
    }
}
