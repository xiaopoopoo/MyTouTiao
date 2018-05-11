//
//  UserDetail.swift
//  MyTouTiao
//
//  Created by ZhongLiangBaoBeijingTechnologyCompanyLtd. on 2018/5/9.
//  Copyright © 2018年 user. All rights reserved.
//
import Foundation
import HandyJSON
struct LargeImage: HandyJSON {
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
}

struct ThumbImage: HandyJSON {
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
    var ratio: CGFloat { return width / height }
    
}
/// rich_content 中的元素
struct RichContent {
    var uid = ""
    var name = ""
    
    init(_ uid: String, _ name: String) {
        self.uid = uid
        self.name = name
    }
}
//评论相关
struct DongtaiReplyList: HandyJSON {
    var id: Int = 0
    var is_pgc_author: Int = 0
    var user_digg = false
    var user_auth_info = UserAuthInfo()
    var user_id: Int = 0
    var author_badge = [DongtaiAuthorBadge]()
    var user_profile_image_url: String = ""
    var user_name: String = ""
    var user_verified: Bool = false
    var text: String = ""
    var digg_count: Int = 0
    var content_rich_span: String = ""
}

struct DongtaiAuthorBadge: HandyJSON {
    var open_url: String = ""
    var uri: String = ""
    var url_list = [URLList]()
    var url: String = ""
    var width: Int = 0
    var height: Int = 0
}

/// item_type 或 type 是 151  group 有值
struct DongtaiUser: HandyJSON {
    
    var schema: String = ""
    
    var user_verified: Bool = false
    
    var is_friend: Int = 0
    
    var is_blocking: Int = 0
    
    var is_blocked: Int = 0
    
    var user_id: Int = 0
    
    var description: String = ""
    
    var screen_name: String = ""
    
    var avatar_url: String = ""
    
    var verified_reason: String = ""
    
    var id: Int = 0
    var medals = [Any]()
    
    var followers_count: Int = 0
    var followersCount: String { return followers_count.convertString() }
    var followings_count: Int = 0
    var followingsCount: String { return followings_count.convertString() }
    var name: String = ""
    var desc: String = ""
    var is_following: Int = 0
    var verified_content: String = ""
    var user_role_icons = [Any]()
    var remark_name: String = ""
    var user_intro: String = ""
    var profit_user: Bool = false
    var is_verify: Int = 0
    var profit_amount: Int = 0
    var uname: String = ""
    var create_time: Int = 0
    var user_auth_info = UserAuthInfo()
}


struct DongtaiComment: HandyJSON {
    
    var id: Int = 0
    var medals = [Any]()
    var is_blocking = false
    var followers_count: Int = 0
    var followings_count: Int = 0
    var remark_name: String = ""
    var avatar_url: String = ""
    var schema: String = ""
    var user_auth_info = UserAuthInfo()
    var user_id: Int = 0
    var desc: String = ""
    var is_following = false
    var is_friend = false
    var is_blocked = false
    var user_verified: Bool = false
    var verified_content: String = ""
    var user_role_icons = [Any]()
    var name: String = ""
    var screen_name: String = ""
    var is_followed = false
    var user_bury: Int = 0
    var create_time: TimeInterval = 0
    var createTime: String { return create_time.convertString() }
    
    var reply_count: Int = 0
    var digg_count: Int = 0
    var diggCount: String { return digg_count.convertString() }
    var score: Float = 0.0
    var bury_count: Int = 0
    var buryCount: String { return bury_count.convertString()}
    var reply_list = [DongtaiReplyList]()
    var verified_reason: String = ""
    var is_pgc_author = false
    var content_rich_span: String = ""
    var user_relation: Int = 0
    var platform: String = ""
    var user_digg = false
    var user_profile_image_url: String = ""
    var text: String = ""
    var attributedContent: NSAttributedString {
        let emojimanager = EmojiManager()
        return emojimanager.showEmoji(content: text, font: UIFont.systemFont(ofSize: 17))
    }
    
    var content = ""
    var user_name: String = ""
    var author_badge = [DongtaiAuthorBadge]()
    var user = DongtaiUser()
    
}
