//
//  XHChildViewController.swift
//  RSegmentPageView
//
//  Created by iOSzhangting on 2021/1/15.
//

import UIKit

class XHChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        t.backgroundColor = .white
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
extension XHChildViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
