//
//  UIUtilities.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 26/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import UIKit

class UIUtilities:NSObject {
    
    class func alertWith(title: String, message: String,viewCtlr: UIViewController){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle:.alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (tapped) in
            //Do nothing
        }))
        viewCtlr.present(alert, animated: true, completion: nil)
    }
    
    class func navigationBarAppearance(){
        guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else { return }

        navigationController.navigationBar.barTintColor = UIColor.init(hexString: Constants.navigationBarColor)
        navigationController.navigationBar.tintColor = UIColor.white
        let navigationAttributes = [.font: UIFont.boldSystemFont(ofSize: CGFloat(Constants.navigationBarFontSize)),NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.titleTextAttributes = navigationAttributes
    }
}
