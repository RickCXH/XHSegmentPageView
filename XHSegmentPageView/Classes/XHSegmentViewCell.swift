//
//  XHSegmentViewCell.swift
//  RSegmentPageView
//
//  Created by Rick on 2021/1/14.
//

import UIKit
import SnapKit

class XHSegmentViewCell: UICollectionViewCell {
    
    var model: XHSegmentTitleModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
            if model.isSelected {
                titleLabel.textColor = model.titleSelectedColor
            } else {
                titleLabel.textColor = model.titleNormalColor
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
