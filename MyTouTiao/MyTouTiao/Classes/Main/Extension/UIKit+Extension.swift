//
//  UIKit+Extension.swift
//  MyTouTiao
//
//  Created by ZhongLiangBaoBeijingTechnologyCompanyLtd. on 2018/4/28.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit
import CoreText
protocol RegisterCellFromNib {}
extension RegisterCellFromNib {
    
    static var identifier: String { return "\(self)" }//实现分类的方法，返回类的名字字符串
    
    static var nib: UINib? { return UINib(nibName: "\(self)", bundle: nil) }//返回该类的NIB
}
