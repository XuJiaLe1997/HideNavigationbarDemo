//
//  ViewControlle.swift
//  HideNavigationbarDemo
//
//  Created by Xujiale on 2020/2/4.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            let vc = FirstController()
            let navVC = UINavigationController(rootViewController: vc)
            present(navVC, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "secondSegue", sender: nil)
        }
    }
    
}
