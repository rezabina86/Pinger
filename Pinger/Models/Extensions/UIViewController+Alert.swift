//
//  UIViewController+Alert.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let actionController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok".localized, style: .cancel)
        actionController.addAction(action)
        self.present(actionController, animated: true)
    }
    
}
