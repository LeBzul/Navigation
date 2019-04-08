//
//  ViewController2.swift
//  Navigation
//
//  Created by Drouin on 02/04/2019.
//  Copyright © 2019 VersusMind. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
 
    @IBAction func showController3() {
        if let controller = Navigation.getViewController("Controller3") {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
