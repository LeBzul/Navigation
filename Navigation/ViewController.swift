//
//  ViewController.swift
//  Navigation
//
//  Created by Drouin on 02/04/2019.
//  Copyright © 2019 VersusMind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var text = ""
        text += "-> ALL Storyboard Name :\n"
        text += "\(Navigation.getAllStoryboardName())\n\n"
        
        text += "-> ALL ViewController IdStoryboard :\n"
        text += "\(Navigation.getAllViewControllerId())\n\n"
        
        text += "-> ViewController IdStoryboard in Main Storyboard :\n"
        text += "\(Navigation.getAllViewControllerId(inStoryboard: "Main"))\n\n"
        
        text += "-> ViewController IdStoryboard \"Hello\" exist ?\n"
        text += "\(Navigation.controllerExist("hello"))\n\n"
        
        text += "-> ViewController IdStoryboard \"MainViewController\" exist?\n"
        text += "\(Navigation.controllerExist("MainViewController"))\n\n"
        
        text += "-> Get ViewController IdStoryboard \"MainViewController\" :\n"
        text += "\(Navigation.getViewController("MainViewController"))\n\n"
        
        text += "-> Get ViewController IdStoryboard \"Hello\" :\n"
        text += "\(Navigation.getViewController("Hello"))\n\n"
        
        text += "-> Get entry point in Main Storyboard :\n"
        text += "\(Navigation.getEntryPoint(inStoryboard: "Main"))\n\n"
        
        text += "-> Get External Storyboard reference in Main  :\n"
        text += "\(Navigation.getExternalStoryboardReference(inStoryboard: "Main"))\n\n"
        
        label.text = text
    }
    
    @IBAction func showController2() {
        if let controller = Navigation.getViewController("Controller2") {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
   
}

