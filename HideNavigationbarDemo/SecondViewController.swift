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
        
        let lbtn = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(back))
        navigationItem.setLeftBarButton(lbtn, animated: true)
        let btn = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
        navigationItem.setRightBarButton(btn, animated: true)
        
        navigationItem.titleView = titleLabel
        titleLabel.text = "标题"
        titleLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        titleLabel.textAlignment = .center
        
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
        
        setNavBarBackgroundColor(color: .white)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(navigationController == nil) {
            return
        }
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = (navigationController?.navigationBar.frame.height)!
        let maxAlphaOffset = CGFloat(200)
        let minAlphaOffset = CGFloat(0)
        let offset = scrollView.contentOffset.y + (statusBarHeight + navigationBarHeight)
        let a = max(min((offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset), 1), 0)
        setNavBarBackgroundColorAlpha(alpha: a)
        titleLabel.textColor = UIColor(red: 1 - a, green: 1 - a, blue: 1 - a, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(red: 1 - a, green: 1 - a, blue: 1 - a, alpha: 1)
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
        dismiss(animated: true, completion: nil)
    }
    
}

class MyImageTableCell: UITableViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    
    func setCell(img: String) {
        imageV.contentMode = .scaleToFill
        imageV.image = UIImage(named: img)
    }
}



