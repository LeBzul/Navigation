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
    // Singleton
    internal static let instance = NavigationSingleton()
    
    enum PlistKey: String {
        case identifierNibName = "UIViewControllerIdentifiersToNibNames"
        case entryPoint = "UIStoryboardDesignatedEntryPointIdentifier"
        case externalReference = "UIViewControllerIdentifiersToExternalStoryboardReferences"
    }
    
    private var storyboards: [Storyboard]!
    
    private init() {
        //   dictionnary = getAllStoryboard()
        storyboards = contructArrayStoryboard()
    }
    
    private func contructArrayStoryboard() -> [Storyboard] {
        var storyboards = [Storyboard]()
        var arrayName = [String]()
        
        if let directory = Bundle.main.resourcePath {
            // Storyboard file is in Base.lproj
            let allResources = try! FileManager.default.contentsOfDirectory(atPath: directory)
            // Filtered and add storyboard file
            arrayName.append(contentsOf: allResources.filter({ $0.hasSuffix(".storyboardc" )}))
            for name in arrayName {
                let shortName = name.split(separator: ".")[0] // cut extension
                // dictionnary.updateValue(getAllController(namesStoryBoard: "\(directory)/\(name)"), forKey: String(shortName))
                storyboards += findAndParsePlist(in: "\(directory)/\(name)", shortName: String(shortName))
            }
            
            arrayName = [String]()
            let lprojs = allResources.filter({ $0.hasSuffix(".lproj" )})
            for lproj in lprojs {
                let allResources = try! FileManager.default.contentsOfDirectory(atPath: "\(directory)/\(lproj)")
                // Filtered and add storyboard file
                arrayName.append(contentsOf: allResources.filter({ $0.hasSuffix(".storyboardc" )}))
                for name in arrayName {
                    let shortName = name.split(separator: ".")[0]
                    storyboards += findAndParsePlist(in: "\(directory)/\(lproj)/\(name)", shortName: String(shortName))
                }
            }
        }
        return storyboards
    }
    
    // Search plist in "storyboardc", Parse and
    // Return : [Storyboard]
    private func findAndParsePlist(in storyboardName: String, shortName: String) ->  [Storyboard] {
        var storyboardArray = [Storyboard]()
        
        let directory = "\(storyboardName)"
        if let directory =  URL(string: directory) {
            guard let files = try? FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles) else {
                return [Storyboard]()
            }
            
            let plists = files.filter({ $0.pathExtension == "plist"})
            for plist in plists {
                if let storyboard = parsePlist(file: plist.absoluteString, shortName: shortName) {
                    storyboardArray.append(storyboard)
                }
            }
        }
        return storyboardArray
    }
    
    private func parsePlist(file: String, shortName: String) -> Storyboard? {
        var nsDictionary = NSDictionary()
        if let url = URL(string: file) {
            nsDictionary = NSDictionary(contentsOf: url) ?? NSDictionary()
            
            let entryPoint: String = (nsDictionary.value(forKey: PlistKey.entryPoint.rawValue) as? String) ?? "none"
            let identifiersNibName = (nsDictionary.value(forKey: PlistKey.identifierNibName.rawValue) as? Dictionary<String, String>) ?? Dictionary<String, String>()
            
            
            let externalReference = (nsDictionary.value(forKey: PlistKey.externalReference.rawValue) as? Dictionary<String, Dictionary<String, String>>) ?? Dictionary<String, Dictionary<String, String>>()
            
            
            var externalReferenceName = [(key: String, id: String)]()
            for reference in externalReference {
                for controller in reference.value {
                    externalReferenceName.append((key: reference.key, id: controller.value))
                }
            }
            
            var arrayController = [(name: String, id: String)]()
            for idDictionnary in identifiersNibName {
                arrayController.append((name: idDictionnary.key, id: idDictionnary.key))
            }
            return Storyboard(fileName: shortName,
                              entryPoint: entryPoint,
                              arrayController: arrayController,
                              externalReferenceName: externalReferenceName)
        }
        return nil
    }
    
    // MARK : - Accessible method
    // Return true if dictionnary contain controller Name
    func controllerExist(_ id: String) -> Bool {
        for storyboard in storyboards {
            for controllersName in storyboard.arrayController where controllersName.id == id {
                return true
            }
        }
        return false
    }
    
    func getEntryPoint(inStoryboard name: String) -> String? {
        for storyboard in storyboards where storyboard.fileName == name {
            return storyboard.entryPoint
        }
        return nil
    }
    
    func getExternalStoryboardReference(inStoryboard name: String) -> [String] {
        var arrayName = [String]()
        for storyboard in storyboards where storyboard.fileName == name {
            for reference in storyboard.externalReferenceName {
                arrayName.append(reference.id)
            }
        }
        return arrayName
    }
    
    
    func getViewController(_ id: String) -> UIViewController? {
        for storyboard in storyboards {
            for controller in storyboard.arrayController where controller.id == id {
                let storyboard = UIStoryboard(name: storyboard.fileName, bundle: nil)
                return storyboard.instantiateViewController(withIdentifier: controller.id)
            }
        }
        return nil
    }
    
    func getAllStoryboardName() -> [String] {
        var arrayNames = [String]()
        for storyboard in storyboards {
            arrayNames.append(storyboard.fileName)
        }
        return arrayNames
    }
    
    func getAllViewControllerId() -> [String] {
        var arrayNames = [String]()
        for storyboard in storyboards {
            for controllerName in storyboard.arrayController {
                arrayNames.append(controllerName.id)
            }
        }
        return arrayNames
    }
    
    func getAllViewControllerId(inStoryboard name: String) -> [String] {
        var arrayNames = [String]()
        for storyboard in storyboards where storyboard.fileName == name {
            for controllerName in storyboard.arrayController {
                arrayNames.append(controllerName.id)
            }
        }
        return arrayNames
    }
}
