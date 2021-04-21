//
//  BaseNavigationController.swift
//  MovieMobileTask
//
//  Created by ALY on 08/04/2021.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    
    //MARK:- LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //            self.navigationBar.prefersLargeTitles = false
        self.isNavigationBarHidden = true
        //            self.navigationBar.isTranslucent = true
        //            self.navigationBar.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8235294118, blue: 0.9333333333, alpha: 1)
        //            self.navigationBar.shadowImage = UIImage()
        //            self.navigationBar.barTintColor = .white
        //
        //            let textAttributes: [NSAttributedString.Key: Any] = [
        //                .foregroundColor : UIColor.black,
        //                .font : semiBoldFont(40.61)
        //            ]
        //            self.navigationBar.titleTextAttributes = textAttributes
        
        let vc = SearchViewController.init()
        self.pushViewController(vc, animated: true)
        
    }
    
    
}

