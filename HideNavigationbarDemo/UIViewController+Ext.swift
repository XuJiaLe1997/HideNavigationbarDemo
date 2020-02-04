//
//  UIViewController+Ext.swift
//  HideNavigationbarDemo
//
//  Created by Xujiale on 2020/2/4.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

private var navigationBarBackgroundKey = "navigationBarBackgroundKey"

extension UIViewController {
    
    func setNavBarBackgroundColor(color: UIColor) {
        // 不能直接在extension中增加存储属性，所以使用runtime插入属性
        let backgroundView = objc_getAssociatedObject(self, &navigationBarBackgroundKey) as? UIView
        
        if backgroundView == nil {
            // 导航栏设为透明
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
            
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            let navigationBarHeight = (navigationController?.navigationBar.frame.height)!
            // 使用一个占位的view模拟导航栏背景
            // 修改此view的背景在视觉上等同于修改导航栏的背景
            let backView = UIView(frame: CGRect(x: 0,
                                                      y: 0, // view是全屏幕的，包括了导航栏和状态栏
                                                      width: view.frame.width,
                                                      height: statusBarHeight + navigationBarHeight))
            backView.backgroundColor = color
            backView.isUserInteractionEnabled = false
            backView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            backView.layer.borderWidth = 0.3
            backView.layer.borderColor = UIColor.lightGray.cgColor
            view.addSubview(backView)
            objc_setAssociatedObject(self, &navigationBarBackgroundKey, backView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            backgroundView!.backgroundColor = color
        }
    }
    
    // 调用此方法修改导航栏透明度
    func setNavBarBackgroundColorAlpha(alpha:CGFloat) {
        let backgroundView = objc_getAssociatedObject(self, &navigationBarBackgroundKey) as? UIView
        if(backgroundView != nil) {
            backgroundView?.alpha = alpha
            // 确保处于view的最顶层，防止被覆盖
            view.bringSubviewToFront(backgroundView!)
        }
    }
}
