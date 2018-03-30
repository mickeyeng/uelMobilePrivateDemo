//
// AlertController.swift
//  myMovie2
//
//  Created by Mickey English on 26/03/2018.
//  Copyright © 2018 Mickey English. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func withError(error: NSError) -> UIAlertController {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        return alert
    }
}
