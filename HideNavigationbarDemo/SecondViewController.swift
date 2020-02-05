//
//  TableViewController.swift
//  HideNavigationbarDemo
//
//  Created by Xujiale on 2020/2/4.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [String] = []
    var titleLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        
        for _ in 0...5 {
            items.append("night")
        }
        
        setCustomNavigationBar(.white)
        
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
        
        let navigationBarHeight = (navigationController?.navigationBar.frame.height)!
        tableView.frame = CGRect(x: 0,
                                 y: -navigationBarHeight,
                                 width: view.frame.width,
                                 height: view.frame.height + navigationBarHeight)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        restoreNavigationBar()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(navigationController == nil) {
            return
        }
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let maxAlphaOffset = CGFloat(200)
        let minAlphaOffset = CGFloat(0)
        let offset = scrollView.contentOffset.y + statusBarHeight
        let a = max(min((offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset), 1), 0)
        setCustomNavigationBarColor(alpha: a)
        titleLabel.textColor = UIColor(red: 1 - a, green: 1 - a, blue: 1 - a, alpha: 1)
        customNavigationBar!.tintColor = UIColor(red: 1 - a, green: 1 - a, blue: 1 - a, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myImageCell", for: indexPath) as! MyImageTableCell
        cell.setCell(img: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    @objc func back() {
         navigationController?.popViewController(animated: true)
    }
    
}

class MyImageTableCell: UITableViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    
    func setCell(img: String) {
        imageV.contentMode = .scaleToFill
        imageV.image = UIImage(named: img)
    }
}



