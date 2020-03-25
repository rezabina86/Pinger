//
//  UITableView+EmptyState.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

extension UITableView {
    
    func showEmptyView(title: String?, body: String?) {
        let emptyView = EmptyStateView(frame: self.frame)
        emptyView.title = title
        emptyView.body = body
        self.backgroundView = emptyView
    }
    
    func hideEmptyView() {
        self.backgroundView = nil
    }
    
}
