//
//  Caption.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

class Caption: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.font = UIFont.PGFonts.CaptionFont
        self.numberOfLines = 0
    }

}
