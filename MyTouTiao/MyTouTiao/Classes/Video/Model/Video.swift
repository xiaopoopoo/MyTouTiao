//
//  Video.swift
//  MyTouTiao
//
//  Created by ZhongLiangBaoBeijingTechnologyCompanyLtd. on 2018/5/9.
//  Copyright © 2018年 user. All rights reserved.
//

import HandyJSON
struct RealVideo: HandyJSON {
    var status: Int = 0
    var user_id: String = ""
    var video_id: String = ""
    var validate: Int = 0
    var enable_ssl: Bool = false
    var video_duration: Float = 0.0
    var video_list = VideoList()
}
struct VideoList: HandyJSON {
    var video_1 = Video()
    var video_2 = Video()
    var video_3 = Video()
}

struct Video: HandyJSON {
    var logo_name: String = ""
    var coded_format: String = ""
    var vwidth: Int = 0
    var socket_buffer: Int = 0
    var preload_interval: Int = 0
    var preload_size: Int = 0
    var preload_min_step: Int = 0
    var bitrate: Int = 0
    var size: Int = 0
    /// 用 base 64 加密的视频真实地址
    var main_url: String = ""
    var mainURL: String {
        let decodeData = Data(base64Encoded: main_url, options: Data.Base64DecodingOptions(rawValue: 0))
        return String(data: decodeData!, encoding: .utf8)!
    }
    
    var user_video_proxy: Int = 0
    var backup_url_1: String = ""
    var preload_max_step: Int = 0
    var definition: String = ""
    var vheight: Int = 0
    var vtype: String = ""
    var height: Int = 0
//    var download_addr = DownloadAddr()
//    var play_addr = PlayAddr()
//    var origin_cover = OriginCover()
    var width: Int = 0
    var duration: CGFloat = 0.0
    var video_id: String = ""
    var ratio: String = ""
}

struct SpecialColumn: HandyJSON {
    
}
extension VideoCell {
    /// 视频播放时隐藏 cell 的部分子视图
    func hideSubviews() {
        titleLabel.isHidden = true
        playCountLabel.isHidden = true
        timeLabel.isHidden = true
        vImageView.isHidden = true
        avatarButton.isHidden = true
        nameLable.isHidden = true
        shareStackView.isHidden = false
    }
    
    /// 设置当前 cell 的属性
    func showSubviews() {
        titleLabel.isHidden = false
        playCountLabel.isHidden = false
        timeLabel.isHidden = false
        avatarButton.isHidden = false
//      vImageView.isHidden = !video.user_verified
        nameLable.isHidden = false
        shareStackView.isHidden = true
    }
}
