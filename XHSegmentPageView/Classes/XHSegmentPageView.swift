//
//  XHSegmentPageView.swift
//  RSegmentPageView
//
//  Created by iOSzhangting on 2021/1/15.
//

import UIKit
import SnapKit

open class XHSegmentPageView: UIView {
    
    private weak var superView: UIViewController?
    private let children: [UIViewController]
    private let config: XHSegmentConfig

    @objc public init(frame: CGRect, superView: UIViewController, children: [UIViewController], config: XHSegmentConfig) {
        self.superView = superView
        self.children = children
        self.config = config
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(segmentHeadView)
        addSubview(pageView)
        segmentHeadView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(config.segmentHeight)
        }
        
        pageView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(segmentHeadView.snp.bottom)
        }
    }
    
    private lazy var segmentHeadView: XHSegmentView = {
        let v = XHSegmentView(frame: CGRect.zero, config: config)
        v.delegate = self
        return v
    }()
    
    private lazy var pageView: XHPageView = {
        let v = XHPageView(frame: CGRect.zero, superView: superView!, children: children)
        v.delegate = self
        return v
    }()

}


extension XHSegmentPageView: XHSegmentViewDelegate {
    
    public func segmentView(_ view: XHSegmentView, didSelectItemAt index: Int) {
        pageView.scrollToItem(to: index)
    }

}

extension XHSegmentPageView: XHPageViewDelegate {
    
    public func segmentPageView(_ view: XHPageView, didScrollAt index: Int) {
        segmentHeadView.scrollToItem(to: index)
    }
    
}
