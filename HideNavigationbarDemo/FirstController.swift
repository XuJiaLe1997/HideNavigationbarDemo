//
//  ViewController.swift
//  HideNavigationbarDemo
//
//  Created by Xujiale on 2020/2/4.
//  Copyright © 2020 xujiale. All rights reserved.
//

/*
 * 沉浸式导航栏最基础的应用，在UIViewController中直接使用
 */

import UIKit

class FirstController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var items: [String] = []
    var titleLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...30 {
            items.append("第 \(i) 个item")
        }
        
        // 设置导航栏颜色为白色
        setCustomNavigationBar(.white)
        
        // 导航栏图标和标题
        let mNavigationItem = UINavigationItem()
        let lbtn = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(back))
        mNavigationItem.setLeftBarButton(lbtn, animated: true)
        let rbtn = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
        mNavigationItem.setRightBarButton(rbtn, animated: true)
        titleLabel.text = "标题"
        titleLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        titleLabel.textAlignment = .center
        mNavigationItem.titleView = titleLabel
        
        customNavigationBar?.items = [mNavigationItem]
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyTableCell.classForCoder(), forCellReuseIdentifier: "myTableCell")
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableCell", for: indexPath) as! MyTableCell
        cell.setCell(title: items[indexPath.row])
        return cell
    }
    
    // MARK: 重写该方法，以便根据滑动距离确认透明度的取值 (注释比代码还多，看不懂就真该打了，哈哈～)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(navigationController == nil) {
            return
        }
        
        // 状态栏高度
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        // 最大偏移量: scrollView向下滑动该距离 后 导航栏全不透明
        let maxAlphaOffset = CGFloat(200)
        // 最小偏移量: scrollView向下滑动该距离 前 导航栏全透明
        let minAlphaOffset = CGFloat(0)
        
        // 已滑动距离: 加上状态栏的高度是因为scrollView一开始
        // 已经默认向上滑动了这段距离，可以自己打印看看偏移量
        let offset = scrollView.contentOffset.y + statusBarHeight
        
        // 按比例计算alpha，且取值必须在 [0,1]
        let a = max(min((offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset), 1), 0)
        
        // 根据计算得到的alpha修改导航栏透明度
        setCustomNavigationBarColor(alpha: a)
        // 导航栏字体或者图标的颜色也可以跟着修改
        titleLabel.textColor = UIColor(red: 1 - a, green: 1 - a, blue: 1 - a, alpha: 1)
        customNavigationBar!.tintColor = UIColor(red: 1 - a, green: 1 - a, blue: 1 - a, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 离开当前页面需要恢复导航栏样式，不影响其他页面
        restoreNavigationBar()
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}

class MyTableCell: UITableViewCell {
    
    var titleLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        backgroundColor = .lightGray
    }
    
    override func layoutSubviews() {
        titleLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
    }
    
    func setCell(title: String) {
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

