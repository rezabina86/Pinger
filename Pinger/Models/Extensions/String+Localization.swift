//
//  String+Localization.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        if let _ = UserDefaults.standard.string(forKey: "i18n_language") {} else {
            UserDefaults.standard.set("en", forKey: "i18n_language")
            UserDefaults.standard.synchronize()
        }
        
        let lang = UserDefaults.standard.string(forKey: "i18n_language")
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
}
