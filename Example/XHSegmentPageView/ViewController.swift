//
//  ViewController.swift
//  XHSegmentPageView
//
//  Created by RickCXH on 01/15/2021.
//  Copyright (c) 2021 RickCXH. All rights reserved.
//

import UIKit
@_exported import SnapKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenheight = UIScreen.main.bounds.height

class ViewController: UIViewController {
    
    let dataList: [String] = ["整体", "组合"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "XHSegmentPageView"
        
        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var tableView: UITableView = {
        let t = UITableView.init(frame: CGRect.zero, style: .plain)
        t.backgroundColor = UIColor.white
        t.dataSource = self
        t.delegate = self
        t.tableHeaderView = UIView()
        t.tableFooterView = UIView()
        t.sectionHeaderHeight = 0.01
        t.sectionFooterHeight = 0.01
        t.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return t
    }()

}

// MARK: - UITableViewDataSource UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(XHDemo1ViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(XHDemo2ViewController(), animated: true)
        default:()
        }
    }
    
}

