//
//  HomeViewController.swift
//  MyTouTiao
//
//  Created by ZhongLiangBaoBeijingTechnologyCompanyLtd. on 2018/4/25.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit
import SGPagingView
import RxSwift
import RxCocoa
class HomeViewController: UIViewController {
    /// 标题和内容
    private var pageTitleView:SGPageTitleView?
    private var pageContentView:SGPageContentView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI
        setupUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.theme_backgroundColor="colors.windowColor"
        navigationController?.navigationBar.barStyle = .black//相当于self.navigationController 当前控制器的样式会变成黑色
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background" + (UserDefaults.standard.bool(forKey: isNight) ? "_night" : "")), for: .default)//设置高亮模式下的图片，顶部的时间和信号默认是白色
    }


}
//分类
extension HomeViewController{
    //设置 UI
    private func setupUI(){
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        NetworkTool.loadHomeNewsTitleData {
           _ = $0.compactMap({ (newsTitle) -> () in //遍列出第0个参数，datas的值，"_"是一个变量，当一个变量在函数体内不使用，可以用"_"代替
                switch newsTitle.category {  //取出model中的品种，根据品种创建不同的继承于HomeTableViewController的子类控制器,该控制器继承自UITableViewControl，放入到ChildViewController中
                case .video:            // 视频
                    let videoTableVC = VideoTableViewController()
                    videoTableVC.newsTitle = newsTitle
                    videoTableVC.setupRefresh(with: .video)
                    self.addChildViewController(videoTableVC)
                case .essayJoke:        // 段子
                    let essayJokeVC = HomeJokeViewController()
//                    essayJokeVC.isJoke = true
                    essayJokeVC.setupRefresh(with: .essayJoke)
                    self.addChildViewController(essayJokeVC)
                case .imagePPMM:        // 街拍
                    let imagePPMMVC = HomeJokeViewController()
//                    imagePPMMVC.isJoke = false
                    imagePPMMVC.setupRefresh(with: .imagePPMM)
                    self.addChildViewController(imagePPMMVC)
                case .imageFunny:        // 趣图
                    let imagePPMMVC = HomeJokeViewController()
//                    imagePPMMVC.isJoke = false
                    imagePPMMVC.setupRefresh(with: .imageFunny)
                    self.addChildViewController(imagePPMMVC)
                case .photos:           // 图片,组图
                    let homeImageVC = HomeImageViewController()
                    homeImageVC.setupRefresh(with: .photos)
                    self.addChildViewController(homeImageVC)
                case .jinritemai:       // 特卖
                    let temaiVC = TeMaiViewController()
//                    temaiVC.url = "https://m.maila88.com/mailaIndex?mailaAppKey=GDW5NMaKQNz81jtW2Yuw2P"
                    self.addChildViewController(temaiVC)
                default :
                    let homeTableVC = HomeRecommendController()
                    homeTableVC.setupRefresh(with: newsTitle.category)
                    self.addChildViewController(homeTableVC)
                }
            
            })
            
            // 内容视图
            self.pageContentView = SGPageContentView(frame: CGRect(x: 0, y: newsTitleHeight, width: screenWidth, height:screenHeight - newsTitleHeight), parentVC: self, childVCs: self.childViewControllers)
//            self.pageContentView!.delegatePageContentView = self as! SGPageContentViewDelegate
            self.view.addSubview(self.pageContentView!)
            
            
        }
    }
}
