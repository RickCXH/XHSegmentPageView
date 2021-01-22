//
//  XHSegmentViewCell.swift
//  RSegmentPageView
//
//  Created by Rick on 2021/1/14.
//

import UIKit
import SnapKit

class XHSegmentViewCell: UICollectionViewCell {
    
    var config: XHSegmentConfig?
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                titleLabel.textColor = config?.titleSelectedColor
            } else {
                titleLabel.textColor = config?.titleNormalColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private(set) lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.setContentCompressionResistancePriority(.required, for: .horizontal)
        return l
    }()
    
}
