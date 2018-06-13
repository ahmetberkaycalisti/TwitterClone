//
//  TabBarVC.swift
//  TwitterClone
//
//  Created by Ahmet Berkay CALISTI on 13/06/2018.
//  Copyright © 2018 Ahmet Berkay CALISTI. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let color = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)

        
        // color of item in tabbar controller
        self.tabBar.tintColor = .white
        
        // color of background of tabbar controller
        self.tabBar.barTintColor = colorBrandBlue
        
        // disable translucent
        self.tabBar.isTranslucent = false
        
        // color of text under icon in tabbar controller
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:color], for: UIControlState())

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.white], for: .selected)
        
        // new color for all icons of tabbar controller
        for item in self.tabBar.items! as [UITabBarItem] {
            
            if let image = item.image  {
                item.image = image.imageColor(color: color).withRenderingMode(.alwaysOriginal)
            }
        }
    }

 

}

// new class we created to refer to our icon in tabbar controller
extension UIImage {
    
    // in this class we customize our uiimage - our icon
    func imageColor(color:UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)

        color.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
