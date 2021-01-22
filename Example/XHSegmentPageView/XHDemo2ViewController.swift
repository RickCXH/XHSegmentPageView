//
//  XHDemo2ViewController.swift
//  XHSegmentPageView_Example
//
//  Created by iOSzhangting on 2021/1/22.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import XHSegmentPageView

class XHDemo2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(segmentHeadView)
        view.addSubview(segmentPageView)
        segmentHeadView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(30)
        }

        segmentPageView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(segmentHeadView.snp.bottom)
        }
    }

    
    
    private lazy var segmentHeadView: XHSegmentView = {
        let config = XHSegmentConfig()
        config.titleArray = items
        let v = XHSegmentView(frame: CGRect.zero, config: config)
        v.delegate = self
        return v
    }()

    private lazy var segmentPageView: XHPageView = {
        let v = XHPageView(frame: CGRect.zero, superView: self, children: vcs)
        v.delegate = self
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
        return ["要闻", "推荐", "小视频", "新时代"]
    }()
    
}

extension XHDemo2ViewController: XHSegmentViewDelegate {

    func segmentView(_ view: XHSegmentView, didSelectItemAt index: Int) {
        segmentPageView.scrollToItem(to: index)
    }


}

extension XHDemo2ViewController: XHPageViewDelegate {

    func segmentPageView(_ view: XHPageView, didScrollAt index: Int) {
        segmentHeadView.scrollToItem(to: index)
    }

}
