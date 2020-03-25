//
//  EmptyStateView.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    private let titleLabel = configure(H1(), using: {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
    })
    
    private let bodyLabel = configure(Caption(), using: {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
    })
    
    public var title: String? {
        willSet { titleLabel.text = newValue }
    }
    
    public var body: String? {
        willSet { bodyLabel.text = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: safeTopAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeLeadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeTrailingAnchor, constant: -16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: safeCenterXAnchor, constant: 0).isActive = true
        
        addSubview(bodyLabel)
        bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        bodyLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeBottomAnchor, constant: -16).isActive = true
        bodyLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeLeadingAnchor, constant: 16).isActive = true
        bodyLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeTrailingAnchor, constant: -16).isActive = true
        bodyLabel.centerXAnchor.constraint(equalTo: safeCenterXAnchor, constant: 0).isActive = true
        bodyLabel.centerYAnchor.constraint(equalTo: safeCenterYAnchor, constant: 0).isActive = true
    }

}
