//
//  XHDemoViewController1.swift
//  XHSegmentPageView_Example
//
//  Created by iOSzhangting on 2021/1/22.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import XHSegmentPageView

class XHDemo1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(pageView)

        pageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var pageView: XHSegmentPageView = {
        let config = XHSegmentConfig()
        config.titleArray = items
        config.indicatorType = .automaticDimension
        config.type = .automaticDimension
        let v = XHSegmentPageView(frame: CGRect.zero, superView: self, children: vcs, config: config)
        return v
    }()
    
    private lazy var vcs: [XHChildViewController] = {
        var list: [XHChildViewController] = []
        items.forEach { (_) in
            list.append(XHChildViewController())
        }
        return list
    }()
    
    private lazy var items: [String] = {
        return ["要闻", "推荐", "抗肺炎", "视频", "新时代",
                "娱乐", "体育", "军事", "小视频", "微天下"]
    }()

}
