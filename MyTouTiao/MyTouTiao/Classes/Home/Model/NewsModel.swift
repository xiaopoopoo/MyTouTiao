//
//  NewsModel.swift
//  MyTouTiao
//
//  Created by ZhongLiangBaoBeijingTechnologyCompanyLtd. on 2018/5/8.
//  Copyright © 2018年 user. All rights reserved.
//


import HandyJSON

enum CellType: Int, HandyJSONEnum {
    case none = 0
    /// 用户
    case user = 32
    /// 相关关注
    case relatedConcern = 50
    
}

enum NewsLabelStyle: Int, HandyJSONEnum {
    case none = 0
    case topOrLive = 1      // 置顶或直播
    case ad = 3             // 广告
}

/// 图片的类型
enum ImageType: Int, HandyJSONEnum {
    case normal = 1     // 一般图片
    case gif = 2        // gif 图
}

struct URLList: HandyJSON {
    
    var url: String = ""
}

struct ImageList: HandyJSON {
    var type = ImageType.normal
    
    var height: CGFloat = 0
    
    var url_list = [URLList]()
    
    var url: NSString = ""
    var urlString: String {
        guard url.hasSuffix(".webp") else { return url as String }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    var width: CGFloat = 0
    
    var uri: String = ""
    /// 宽高比
    var ratio: CGFloat? { return width / height }
    
}
struct MiddleImage: HandyJSON {
    var type = ImageType.normal
    var height: CGFloat = 0
    
    var url_list = [URLList]()
    
    var url: NSString = ""
    var urlString: String {
        guard url.hasSuffix(".webp") else { return url as String }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    var width: CGFloat = 0
    
    var uri: String = ""
    /// 宽高比
    var ratio: CGFloat? { return width / height }
    
}
struct SmallVideo: HandyJSON {
    
}
struct MediaInfo: HandyJSON {
    var follow: Bool = false
    var is_star_user: Bool = false
    var recommend_reason: String = ""
    var user_verified: Bool = false
    var media_id: Int = 0
    var verified_content: String = ""
    var user_id: Int = 0
    var recommend_type: Int = 0
    var avatar_url: String = ""
    var name: String = ""
}
struct NewsUserInfo: HandyJSON {
    var follow: Bool = false
    var name: String = ""
    var user_verified: Bool = false
    var verified_content: String = ""
    var user_id: Int = 0
    var id: Int = 0
    var description: String = ""
    var desc: String = ""
    var avatar_url: String = ""
    var follower_count: Int = 0
    var followerCount: String { return follower_count.convertString() }
    var user_decoration: String!
    var subcribed: Int = 0
    var fans_count: Int = 0
    var fansCount: String { return fans_count.convertString() }
    var special_column = [SpecialColumn]()
    var user_auth_info: String!
    var media_id: Int = 0
    var screen_name = ""
    var is_followed: Bool = false
    var is_following: Bool = false // 是否正在关注
    var is_blocking: Bool = false
    var is_blocked: Bool = false
    var is_friend: Bool = false
    var medals = [String]() // hot_post (热门内容)
    
}
struct NewsModel: HandyJSON{
    var article_url: String = ""
    var item_id: Int = 0
    var group_id: Int = 0
    var comment_count: Int = 0
    var commentCount: String { return comment_count.convertString() }
    var publish_time: TimeInterval = 0
    var publishTime: String { return publish_time.convertString() }
    var raw_data = SmallVideo() //小视频数据
    var source: String = ""
    var has_video: Bool = false
    var cell_type: CellType = .none
    var content = ""
    var contentH: CGFloat { return content.textHeight(fontSize: 16, width: screenWidth - 30) }
    var video_duration: Int = 0
    var video_style: Int = 0
    var title: String = ""
    var label: String = ""
    var sub_title = ""
    var label_style: NewsLabelStyle = .none  // 3 是广告,1是置顶
    var hot: Bool = false  // 热
    var is_stick: Bool = false
    var middle_image = MiddleImage()
    var image_list = [ImageList]()
    var videoDuration: String { return video_duration.convertVideoDuration() }
    var large_image_list = [LargeImage]()
    var titleH: CGFloat {
        if video_duration != 0 && video_style == 0 { // // 右侧有图
            return title.textHeight(fontSize: 17, width: screenWidth * 0.72 - 30)
        } else {
            return title.textHeight(fontSize: 17, width: screenWidth - 30)
        }
    }
    var cellHeight: CGFloat {
        // 15 + titleH + 10 + middleViewH + 16 + 10 + bottomViewH + 10
        var height: CGFloat = 61 + titleH
        
        if video_duration != 0 && video_style == 2 {
            height += screenWidth * 0.5
        }
        
        if label_style == .ad && sub_title != "" {
            height += 40
        }
        
        if middle_image.url != "" && image_list.count == 0 { return 95 }
        else {
            if image_list.count != 0 {
                if image_list.count == 1 { return 95 }
                else { height += image3Width }
            }
        }
        
        return height
    }
    var media_info = MediaInfo()
    var user_info = NewsUserInfo()
    var media_name: String = ""
    var video_play_info = VideoPlayInfo()
    var video_detail_info = VideoDetailInfo()
    var ad_button = ADButton()
    var ad_id = 0
    var ad_label = ""
    var type = "" // app
    var app_name = ""
    var appleid = ""
    var description = ""
    var descriptionH: CGFloat { return description.textHeight(fontSize: 13, width: screenWidth - 30) }
    
    var download_url = ""
    var card_type: CardType = .video
    var is_article = false
    var is_preview = false
    var web_url = ""
}
/// 视频类型
enum CardType: String, HandyJSONEnum {
    case video = "video"             // 视频
    case adVideo = "ad_video"        // 广告视频
    case adTextlink = "ad_textlink"  // 广告链接
}
struct VideoURL: HandyJSON {
    
}
struct ADButton: HandyJSON {
    var description: String = ""
    var download_url: String = ""
    var id: Int = 0
    var web_url: String = ""
    var app_name: String = ""
    var track_url: String = ""
    var ui_type: Int = 0
    var click_track_url: String = ""
    var button_text: String = ""
    var display_type: Int = 0
    var hide_if_exists: Int = 0
    var open_url: String = ""
    var source: String = ""
    var type: String = ""
    var package: String = ""
    var appleid: String = ""
    var web_title: String = ""
}
struct DetailVideoLargeImage: HandyJSON {
    var height: Int = 0
    var url_list: [URLList]!
    var url: NSString = ""
    var urlString: String {
        guard url.hasSuffix(".webp") else { return url as String }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    var width: Int = 0
    var uri: String = ""
    
}
struct VideoDetailInfo: HandyJSON {
    var video_preloading_flag: Int = 0
    var direct_play: Int = 0
    var group_flags: Int = 0
    var video_url = [VideoURL]()
    var detail_video_large_image = DetailVideoLargeImage()
    var video_third_monitor_url: String = ""
    var video_watching_count: Int = 0
    var videoWatchingCount: String { return video_watching_count.convertString() }
    var video_id: String = ""
    var video_watch_count: Int = 0
    var videoWatchCount: String { return video_watch_count.convertString() }
    var video_type: Int = 0
    var show_pgc_subscribe: Int = 0
}
struct DnsInfo: HandyJSON {
    
}
struct OriginalPlayURL: HandyJSON {
    var main_url: String = ""
    var backup_url: String = ""
}

struct VideoPlayInfo: HandyJSON {
    var status: Int = 0
    var dns_info = DnsInfo()
    var enable_ssl: Bool = false
    var poster_url: String = ""
    var message: String = ""
    var video_list = VideoList()
    var original_play_url = OriginalPlayURL()
    var video_duration: Int = 0
    var videoDuration: String {
        return video_duration.convertVideoDuration()
    }
    
    var validate: String = ""
}
//首页每一个cell点击进入详情页
struct NewsDetailImage: HandyJSON {
    
    var url: String = ""
    
    var width: CGFloat = 0
    
    var height: CGFloat = 0
    
    var rate: CGFloat = 1
    
    var url_list = [URLList]()
    
}
