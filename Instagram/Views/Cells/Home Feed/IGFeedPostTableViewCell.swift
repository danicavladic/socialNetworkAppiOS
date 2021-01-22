//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Danica Vladić on 22/09/2020.
//  Copyright © 2020 Danica Vladić. All rights reserved.
//

import UIKit

final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure() {
        //
    }
}
