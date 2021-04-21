//
//  baiseViewController.swift
//  MovieMobileTask
//
//  Created by ALY on 08/04/2021.
//

import UIKit

class baiseViewController: UIViewController {

    // MARK: - Variables
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
  


}
// MARK: - Functions
extension baiseViewController{
    
    // MARK: - Rechability Method
    func isConnectedToNetwork() -> Bool {
        
        if (currentReachabilityStatus == ReachabilityStatus.reachableViaWiFi)
        {
            return true
        }
        else if (currentReachabilityStatus == ReachabilityStatus.reachableViaWWAN)
        {
            return true
            
        }
        else
        {
            return false
        }
    }
}
