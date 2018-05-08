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
struct NewsModel: HandyJSON{
    var raw_data = SmallVideo() //小视频数据
    var source: String = ""
    var has_video: Bool = false
    var cell_type: CellType = .none
    var content = ""
    var contentH: CGFloat { return content.textHeight(fontSize: 16, width: screenWidth - 30) }
    var video_duration: Int = 0
    var video_style: Int = 0
    var title: String = ""
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
        var label_style: NewsLabelStyle = .none
        var sub_title = ""
        if label_style == .ad && sub_title != "" {
            height += 40
        }
        var middle_image = MiddleImage()
        var image_list = [ImageList]()
        if middle_image.url != "" && image_list.count == 0 { return 95 }
        else {
            if image_list.count != 0 {
                if image_list.count == 1 { return 95 }
                else { height += image3Width }
            }
        }
        
        return height
    }
}
