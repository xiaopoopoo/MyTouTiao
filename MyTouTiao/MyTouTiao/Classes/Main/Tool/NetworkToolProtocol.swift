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
}

//扩展这个协议的方法
extension NetworkToolProtocol {
// MARK: - --------------------------------- 首页 home  ---------------------------------
/// 首页顶部新闻标题的数据
/// - parameter completionHandler: 返回标题数据
/// - parameter newsTitles: 首页标题数组}
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()){
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
}
struct NetworkTool: NetworkToolProtocol {}
