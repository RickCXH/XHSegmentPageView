//
//  XHPageView.swift
//  XHSegmentPageView
//
//  Created by iOSzhangting on 2021/1/15.
//

import UIKit

@objc
public protocol XHPageViewDelegate: NSObjectProtocol {
    func segmentPageView(_ view: XHPageView, didScrollAt index: Int)
}

open class XHPageView: UIView {
    
    public weak var delegate: XHPageViewDelegate?
    
    private weak var superView: UIViewController?
    private let children: [UIViewController]

    @objc public init(frame: CGRect, superView: UIViewController, children: [UIViewController]) {
        self.superView = superView
        self.children = children
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func scrollToItem(to index: Int, animated: Bool = true) {
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
    }
    
    private func setupUI() {
        addSubview(collectionView)
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        l.minimumLineSpacing = 0
        l.minimumInteritemSpacing = 0
        l.scrollDirection = .horizontal
        return l
    }()
    
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        if #available(iOS 11.0, *) {
            v.contentInsetAdjustmentBehavior = .never
        }
        v.backgroundColor = .white
        v.bounces = false
        v.scrollsToTop = false
        v.isPagingEnabled = true
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.dataSource = self
        v.delegate = self
        v.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return v
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout.itemSize = bounds.size
        collectionView.frame = bounds
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension XHPageView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return children.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let childVc = children[indexPath.item]
        if childVc.isViewLoaded { return }
        superView?.addChild(childVc)
        childVc.view.frame = cell.contentView.frame
        cell.contentView.addSubview(childVc.view)
    }
    
}

extension XHPageView {
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/bounds.size.width)
        delegate?.segmentPageView(self, didScrollAt: index)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/bounds.size.width)
        delegate?.segmentPageView(self, didScrollAt: index)
    }
    
}
