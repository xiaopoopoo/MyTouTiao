//
//  NetworkToolProtocol.swift
//  MyTouTiao
//
//  Created by ZhongLiangBaoBeijingTechnologyCompanyLtd. on 2018/4/27.
//  Copyright © 2018年 user. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocol {
    // MARK: - --------------------------------- 首页 home  ---------------------------------
    // MARK: 首页顶部新闻标题的数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
    static func loadApiNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, _ completionHandler: @escaping (_ maxBehotTime: TimeInterval, _ news: [NewsModel]) -> ())
    // MARK: 获取首页、视频、小视频的新闻列表数据,加载更多
    static func loadMoreApiNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> ())
    
    // MARK: 视频首页顶部导航栏搜索推荐标题内容
    static func loadHomeSearchSuggestInfo(_ completionHandler: @escaping (_ searchSuggest: String) -> ())
    
    // MARK: 视频顶部新闻标题的数据
    static func loadVideoApiCategoies(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())

}

//扩展这个协议的方法
extension NetworkToolProtocol {
// MARK: - --------------------------------- 首页 home  ---------------------------------
/// 首页顶部新闻标题的数据
/// - parameter completionHandler: 返回标题数据
/// - parameter newsTitles: 首页标题数组}
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()){//逃逸标记，防止block返回前代码已经执行完
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value{
                let json = JSON(value)//打印的是一个any
                guard json["message"] == "success" else { return }
                if let dataDict = json["data"].dictionary {//是json
                    if let datas = dataDict["data"]?.arrayObject { //any 的数组
                        var titles = [HomeNewsTitle]()//创建一个数组
                        titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"\", \"name\": \"推荐\"}")!)//往数组中添加一个字典
//                        datas.compactMap({   这个方法很有意思，
//                            $0 //第一个参数，相当于得到数组中每一个元素
//                             datas[i]; //假代码
//                             Person p = datas[i]
//                             return p//多次返回每一个对象
//                        })
                        //HomeNewsTitle.deserialize(from: $0 as? Dictionary) 每循环一次把第一个参数边转为一个mode返回
                        //titles+= //每次向titles中放入一个元素
                        titles += datas.compactMap({ HomeNewsTitle.deserialize(from: $0 as? Dictionary) })
                        completionHandler(titles)
                    }
                }
            }
        }
    }
    
    
    
    /// 获取首页、视频、小视频的新闻列表数据上拉刷新
    /// - parameter category: 新闻类别
    /// - parameter ttFrom: 那个界面
    /// - parameter completionHandler: 返回新闻列表数据
    /// - parameter news: 首页新闻数据数组
    static func loadApiNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, _ completionHandler: @escaping (_ maxBehotTime: TimeInterval, _ news: [NewsModel]) -> ()) {
        // 下拉刷新的时间
        let pullTime = Date().timeIntervalSince1970
        let url = BASE_URL + "/api/news/feed/v75/?"
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": 15,
                      "category": category.rawValue,
                      "min_behot_time": pullTime,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "iid": iid] as [String: Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                guard let datas = json["data"].array else { return }
                completionHandler(pullTime, datas.compactMap({ NewsModel.deserialize(from: $0["content"].string) }))
            }
        }
    }
    
    /// 获取首页、视频、小视频的新闻列表数据,加载更多下拉刷新
    /// - parameter category: 新闻类别
    /// - parameter ttFrom: 那个界面
    /// - parameter listCount: 数据数量
    /// - parameter completionHandler: 返回新闻列表数据
    /// - parameter news: 首页新闻数据数组
    static func loadMoreApiNewsFeeds(category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> ()) {
        
        let url = BASE_URL + "/api/news/feed/v75/?"
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": listCount,
                      "category": category.rawValue,
                      "max_behot_time": maxBehotTime,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "iid": iid] as [String: Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                guard let datas = json["data"].array else { return }
                completionHandler(datas.compactMap({ NewsModel.deserialize(from: $0["content"].string) }))
            }
        }
    }
    
    /// 获取图片新闻详情数据，首页点击第一个cell获取详情页的数据
    /// - parameter articleURL: 链接
    /// - parameter completionHandler: 返回图片数组，标题数组
    /// - parameter images: 图片数组
    /// - parameter abstracts: 标题数组
    static func loadNewsDetail(articleURL: String, completionHandler:@escaping (_ images: [NewsDetailImage], _ abstracts: [String])->()) {
        // 测试数据
        //        http://toutiao.com/item/6450211121520443918/
        let url = "http://www.toutiao.com/a6450237670911852814/#p=1"
        
        Alamofire.request(url).responseString { (response) in
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                if value.contains("BASE_DATA.galleryInfo =") {
                    // 获取 图片链接数组
                    let startIndex = value.range(of: ",\\\"sub_images\\\":")!.upperBound
                    let endIndex = value.range(of: ",\\\"max_img_width\\\":")!.lowerBound
                    let BASE_DATA = value[Range(uncheckedBounds: (lower: startIndex, upper: endIndex))]
                    let substring = BASE_DATA.replacingOccurrences(of: "\\\\", with: "")
                    let substring2 = substring.replacingOccurrences(of: "\\", with: "")
                    let data = substring2.data(using: .utf8)! as Data
                    let dicts = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [Any]
                    // 获取 子标题
                    let titleStartIndex = value.range(of: "\\\"sub_abstracts\\\":")!.upperBound
                    let titlEndIndex = value.range(of: ",\\\"sub_titles\\\"")!.lowerBound
                    let sub_abstracts = value[Range(uncheckedBounds: (lower: titleStartIndex, upper: titlEndIndex))]
                    let titleSubstring1 = sub_abstracts.replacingOccurrences(of: "\\\"", with: "\"")
                    let titleSubstring2 = titleSubstring1.replacingOccurrences(of: "\\u", with: "u")
                    let titleData = titleSubstring2.data(using: String.Encoding.utf8)! as Data
                    completionHandler(dicts!.compactMap({ NewsDetailImage.deserialize(from: $0 as? [String: Any])! }), try! JSONSerialization.jsonObject(with: titleData, options: .mutableContainers) as! [String])
                }
            }
        }
    }
    
    //获取图片详情页评论的数据
    /// 获取用户详情一般的详情的评论数据
    /// item_type: postContent(200),postVideo(150),postVideoOrArticle(151)
    /// - parameter forumId: 用户id
    /// - parameter groupId: thread_id
    /// - parameter offset: 偏移
    /// - parameter completionHandler: 返回评论数据
    /// - parameter comments: 评论数据
    static func loadUserDetailNormalDongtaiComents(groupId: Int, offset: Int, count: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ()) {
        
        let url = BASE_URL + "/article/v2/tab_comments/"
        let params = ["forum_id": "",
                      "group_id": groupId,
                      "count": count,
                      "offset": offset,
                      "device_id": device_id,
                      "iid": iid] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { completionHandler([]); return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { completionHandler([]); return }
                if let datas = json["data"].arrayObject {
                    completionHandler(datas.compactMap({
                        return DongtaiComment.deserialize(from: ($0 as! [String: Any])["comment"] as? Dictionary)
                    }))
                }
            }
        }
    }

    /// 视频首页顶部导航栏搜索推荐标题内容
    /// - parameter completionHandler: 返回搜索建议数据
    /// - parameter searchSuggest: 首页搜索建议
    static func loadHomeSearchSuggestInfo(_ completionHandler: @escaping (_ searchSuggest: String) -> ()) {
        let url = BASE_URL + "/search/suggest/homepage_suggest/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let data = json["data"].dictionary {
                    completionHandler(data["homepage_search_suggest"]!.string!)
                }
            }
        }
    }
    
    /// 视频顶部新闻标题的数据
    /// - parameter completionHandler: 返回标题数据
    /// - parameter newsTitles: 视频标题数组
    static func loadVideoApiCategoies(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/video_api/get_category/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let datas = json["data"].arrayObject {
                    var titles = [HomeNewsTitle]()
                    titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"video\", \"name\": \"推荐\"}")!)
                    titles += datas.compactMap({ HomeNewsTitle.deserialize(from: $0 as? Dictionary) })
                    completionHandler(titles)
                }
            }
        }
    }
    
}





struct NetworkTool: NetworkToolProtocol {}
