//
//  XHSegmentConfig.swift
//  RSegmentPageView
//
//  Created by iOSzhangting on 2021/1/15.
//

import UIKit

///指示器类型
public enum XHSegmentIndicatorType: Comparable {
    case none
    case automaticDimension
    case fixWidth(width: CGFloat)
}

/// segment类型
public enum XHSegmentType: Int {
    case automaticDimension
    case fixWidth
}

open class XHSegmentConfig: NSObject {
    
    /// Segment高度
    public var segmentHeight: CGFloat = 30.0
    
    /// 标题字体大小
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 17)
    
    /// 标题数组
    public var titleArray: [String] = []
    
    /// item之间的距离
    public var itemSpace: CGFloat = 10.0
    
    /// 标题正常的颜色
    public var titleNormalColor: UIColor = .black
    
    /// 标题选中的颜色
    public var titleSelectedColor: UIColor = .blue
    
    /// 指示器的高度
    public var indicatorViewHeight: CGFloat = 1.0
    
    /// segmentInset
    public var segmentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    ///指示器类型
    public var indicatorType: XHSegmentIndicatorType = .automaticDimension
    
    /// segment类型
    public var type: XHSegmentType = .automaticDimension
    
}
