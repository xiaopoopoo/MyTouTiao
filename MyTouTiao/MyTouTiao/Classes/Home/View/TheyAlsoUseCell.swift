//
//  TheyAlsoUseCell.swift
//  MyTouTiao
//
//  Created by ZhongLiangBaoBeijingTechnologyCompanyLtd. on 2018/5/8.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit

class TheyAlsoUseCell: UITableViewCell, RegisterCellFromNib {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var theyUse = SmallVideo() {
        didSet {
//            leftLabel.text = theyUse.title
//            rightButton.setTitle(theyUse.show_more, for: .normal)
//            userCards = theyUse.user_cards
//            collectionView.reloadData()
        }
    }
}
