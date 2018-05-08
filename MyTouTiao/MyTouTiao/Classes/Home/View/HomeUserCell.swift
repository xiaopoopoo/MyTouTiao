//
//  HomeUserCellTableViewCell.swift
//  MyTouTiao
//
//  Created by ZhongLiangBaoBeijingTechnologyCompanyLtd. on 2018/5/8.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit

class HomeUserCell: UITableViewCell, RegisterCellFromNib {

    var aNews = NewsModel() {
        didSet {
//            /// 发布者
//            if aNews.source != "" { nameLabel.text = aNews.source }
//            else if aNews.user.user_id != 0 {
//                avatarImageView.kf.setImage(with: URL(string: aNews.user.avatar_url)!)
//                nameLabel.text = aNews.user.screen_name
//            } else if aNews.user_info.user_id != 0 {
//                avatarImageView.kf.setImage(with: URL(string: aNews.user_info.avatar_url)!)
//                nameLabel.text = aNews.user_info.name
//            } else if aNews.media_info.user_id != 0 {
//                nameLabel.text = aNews.media_info.name
//                avatarImageView.kf.setImage(with: URL(string: aNews.media_info.avatar_url)!)
//            }
//            readCountLabel.text = "\(aNews.readCount)阅读"
//            verifiedContentLabel.text = aNews.verified_content
//            digButton.setTitle(aNews.diggCount, for: .normal)
//            commentButton.setTitle("\(aNews.commentCount)", for: .normal)
//            feedshareButton.setTitle(aNews.forwardCount, for: .normal)
//            contentLabel.attributedText = aNews.attributedContent
        }
    }

}
