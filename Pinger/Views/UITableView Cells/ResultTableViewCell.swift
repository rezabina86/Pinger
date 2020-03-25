//
//  ResultTableViewCell.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    private let ipLabel = configure(H1()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "192.168.1.1"
    }
    
    private let reachabilityStatus = configure(UIView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.backgroundColor = .green
        $0.layer.cornerRadius = 6
    }
    
    public var ipAddress: String? {
        willSet {
            ipLabel.text = newValue
        }
    }
    
    public var isReachable: Bool = false {
        willSet {
            reachabilityStatus.backgroundColor = newValue ? .green : .red
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        addSubview(ipLabel)
        ipLabel.topAnchor.constraint(equalTo: safeTopAnchor, constant: 16).isActive = true
        ipLabel.bottomAnchor.constraint(equalTo: safeBottomAnchor, constant: -16).isActive = true
        ipLabel.leadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: 15).isActive = true
        
        addSubview(reachabilityStatus)
        reachabilityStatus.trailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -15).isActive = true
        reachabilityStatus.leadingAnchor.constraint(equalTo: ipLabel.trailingAnchor, constant: 16).isActive = true
        reachabilityStatus.centerYAnchor.constraint(equalTo: safeCenterYAnchor, constant: 0).isActive = true
        reachabilityStatus.widthAnchor.constraint(equalToConstant: 12).isActive = true
        reachabilityStatus.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }

}
