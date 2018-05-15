//
//  VideoDetailViewController.swift
//  MyTouTiao
//
//  Created by ZhongLiangBaoBeijingTechnologyCompanyLtd. on 2018/5/15.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit
import BMPlayer
import RxSwift
import RxCocoa
import SnapKit
import SVProgressHUD

protocol VideoDetailViewControllerDelegate: class {
    /// 详情控制器将要消失
    func VideoDetailViewControllerViewWillDisappear(_ realVideo: RealVideo, _ currentTime: TimeInterval, _ currentIndexPath: IndexPath)
}

class VideoDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
