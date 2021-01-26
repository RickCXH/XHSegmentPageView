//
//  XHSegmentTitleModel.swift
//  XHSegmentPageView
//
//  Created by iOSzhangting on 2021/1/26.
//

import UIKit

class XHSegmentTitleModel: NSObject {
    
    public var title: String?
    
    /// 标题正常的颜色
    public var titleNormalColor: UIColor = .black
    
    /// 标题选中的颜色
    public var titleSelectedColor: UIColor = .blue
    
    public var isSelected: Bool = false
    
}
