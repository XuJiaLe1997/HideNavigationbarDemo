//
//  UIViewController+Ext.swift
//  HideNavigationbarDemo
//
//  Created by Xujiale on 2020/2/4.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

private var navBarHolderViewKey = "navBarHolderViewKey"
private var navBarBackgroundViewKey = "navBarBackgroundViewKey"
private var navBarViewKey = "navBarViewKey"

extension UIViewController {
    
    fileprivate var navBarHolder: UIView? {
        set {
            objc_setAssociatedObject(self, &navBarHolderViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &navBarHolderViewKey) as? UIView
        }
    }
    
    // 计算属性保存自定义的导航栏
    var customNavigationBar: UINavigationBar? {
        set {
            objc_setAssociatedObject(self, &navBarViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &navBarViewKey) as? UINavigationBar
        }
    }
    
    // 计算属性保存导航栏背景占位view
    fileprivate var navBarBackgroundView: UIView? {
        set {
            objc_setAssociatedObject(self, &navBarBackgroundViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &navBarBackgroundViewKey) as? UIView
        }
    }
    
    func setCustomNavigationBar(_ color: UIColor) {
        
        if customNavigationBar == nil {
            // 隐藏导航栏
            navigationController?.navigationBar.isHidden = true
            
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            let navigationBarHeight = (navigationController?.navigationBar.frame.height)!
            
            navBarHolder = UIView(frame: CGRect(x: 0, y: 0,
                                                width: view.frame.width,
                                                height: statusBarHeight + navigationBarHeight))
            navBarHolder?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            navBarBackgroundView = UIView(frame: navBarHolder!.frame)
            navBarBackgroundView?.backgroundColor = color
            navBarHolder?.addSubview(navBarBackgroundView!)
            
            let navBar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: view.frame.width, height: navigationBarHeight))
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
            navBarHolder?.addSubview(navBar)
            view.addSubview(navBarHolder!)
            
            customNavigationBar = navBar
        }
    }
    
    // 调用此方法修改导航栏透明度
    func setCustomNavigationBarColor(alpha: CGFloat) {
        let backgroundView = self.customNavigationBar
        if(backgroundView != nil) {
            navBarBackgroundView?.alpha = alpha
            // 确保处于view的最顶层，防止被覆盖
            view.bringSubviewToFront(navBarHolder!)
        }
    }
    
    func restoreNavigationBar() {
        navigationController?.navigationBar.isHidden = false
    }
}
