//
//  XHSegmentView.swift
//  RSegmentPageView
//
//  Created by Rick on 2021/1/14.
//

import UIKit
import SnapKit

@objc
public protocol XHSegmentViewDelegate: NSObjectProtocol {
    func segmentView(_ view: XHSegmentView, didSelectItemAt index: Int)
}

open class XHSegmentView: UIView {
    
    public weak var delegate: XHSegmentViewDelegate?
    private let config: XHSegmentConfig
    
    private var selectedIndex: Int = 0
    private var cellsSizes: [Int: CGSize] = [:]
    
    private var dataList: [XHSegmentTitleModel] = []
 
    @objc public init(frame: CGRect, config: XHSegmentConfig) {
        self.config = config
        super.init(frame: frame)
        initModel()
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(collectionView)
        if config.indicatorType != .none {
            collectionView.addSubview(indicatorView)
        }
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func initModel() {
        for i in 0..<config.titleArray.count {
            let model = XHSegmentTitleModel()
            model.title = config.titleArray[i]
            model.titleNormalColor = config.titleNormalColor
            model.titleSelectedColor = config.titleSelectedColor
            model.isSelected = (i == selectedIndex)
            dataList.append(model)
        }
    }
    
    public func scrollToItem(to index: Int, animated: Bool = true) {
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? XHSegmentViewCell else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let cell1 = self.collectionView.cellForItem(at: indexPath) as? XHSegmentViewCell {
                    self.updateSelectedItem(index)
                    self.setSelectedIndicatorFrame(cell: cell1, indexPath: indexPath, animated: animated)
                }
            }
            return
        }
        self.updateSelectedItem(index)
        self.setSelectedIndicatorFrame(cell: cell, indexPath: indexPath, animated: animated)
    }
    
    private func setSelectedIndicatorFrame(cell: XHSegmentViewCell, indexPath: IndexPath, animated: Bool = true) {
        switch config.indicatorType {
        case .automaticDimension:
            let width = getTextWidth(index: indexPath.item)
            if animated {
                UIView.animate(withDuration: 0.5) {
                    self.indicatorView.frame.size = CGSize(width: width, height: self.config.indicatorViewHeight)
                    self.indicatorView.center = CGPoint(x: cell.center.x, y: self.bounds.size.height - self.config.indicatorViewHeight)
                }
            } else {
                indicatorView.frame.size = CGSize(width: width, height: config.indicatorViewHeight)
                indicatorView.center = CGPoint(x: cell.center.x, y: self.bounds.size.height - config.indicatorViewHeight)
            }
        case .fixWidth(let width):
            if animated {
                UIView.animate(withDuration: 0.5) {
                    self.indicatorView.frame.size = CGSize(width: width, height: self.config.indicatorViewHeight)
                    self.indicatorView.center = CGPoint(x: cell.center.x, y: self.bounds.size.height - self.config.indicatorViewHeight)
                }
            } else {
                indicatorView.frame.size = CGSize(width: width, height: config.indicatorViewHeight)
                indicatorView.center = CGPoint(x: cell.center.x, y: self.bounds.size.height - config.indicatorViewHeight)
            }
        default:()
        }
        
    }
    
    private func updateSelectedItem(_ index: Int) {
        if index == selectedIndex { return }
        let previousModel = dataList[selectedIndex]
        previousModel.isSelected = false
        if let cell = collectionView.cellForItem(at: IndexPath(item: selectedIndex, section: 0)) as? XHSegmentViewCell {
            cell.model = previousModel
        } else {
            collectionView.reloadData()
        }
        let currentModel = dataList[index]
        currentModel.isSelected = true
        if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? XHSegmentViewCell {
            cell.model = currentModel
        }
        selectedIndex = index
    }
    
    private func getItemSize(_ indexPath: IndexPath) -> CGSize {
        var size = cellsSizes[indexPath.item]
        if size != nil {
            return size!
        }
        switch config.type {
        case .automaticDimension:
            let width = getTextWidth(index: indexPath.item)
            size = CGSize(width: width, height: bounds.size.height)
        case .fixWidth:
            let count: Int = config.titleArray.count
            var totalWidth: CGFloat
            if count >= 1 {
                totalWidth = bounds.size.width - config.segmentInset.left - config.segmentInset.right - config.itemSpace * CGFloat((count - 1))
            } else {
                totalWidth = bounds.size.width - config.segmentInset.left - config.segmentInset.right
            }
            let width = totalWidth / CGFloat(count)
            size = CGSize(width: width, height: bounds.size.height)
        }
        cellsSizes[indexPath.item] = size
        return size!
    }
    
    private func getTextWidth(index: Int) -> CGFloat {
        let attributes: [NSAttributedString.Key : Any] = [.font: config.titleFont]
        let attrString = NSAttributedString(string: config.titleArray[index], attributes: attributes)
        let width = attrString.boundingRect(with: .zero, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).size.width
        return width
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        l.minimumLineSpacing = config.itemSpace
        l.minimumInteritemSpacing = config.itemSpace
        l.sectionInset = config.segmentInset
        l.scrollDirection = .horizontal
        return l
    }()
    
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        if #available(iOS 11.0, *) {
            v.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        v.backgroundColor = .white
        v.bounces = false
        v.scrollsToTop = false
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.dataSource = self
        v.delegate = self
        v.register(XHSegmentViewCell.self, forCellWithReuseIdentifier: "cell")
        return v
    }()
    
    private lazy var indicatorView: UIView = {
        let v = UIView()
        v.backgroundColor = config.titleSelectedColor
        return v
    }()
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension XHSegmentView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: XHSegmentViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! XHSegmentViewCell
        cell.model = dataList[indexPath.item]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex == indexPath.item { return }
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? XHSegmentViewCell else { return }
        updateSelectedItem(indexPath.item)
        setSelectedIndicatorFrame(cell: selectedCell, indexPath: indexPath)
        delegate?.segmentView(self, didSelectItemAt: indexPath.item)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == selectedIndex { //初始化设置指示器的frame
            if let showCell = cell as? XHSegmentViewCell, config.indicatorType != .none {
                setSelectedIndicatorFrame(cell: showCell, indexPath: indexPath, animated: false)
            }
        }
    }

}
 
// MARK: - ICollectionViewDelegateFlowLayout
extension XHSegmentView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getItemSize(indexPath)
    }
    
}




