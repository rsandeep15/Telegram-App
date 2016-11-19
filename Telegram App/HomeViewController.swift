//
//  HomeViewController2.swift
//  Telegram App
//
//  Created by Sandeep on 11/18/16.
//  Copyright © 2016 Sandeep. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        let navItem = self.navigationItem;
        navItem.title = "Home";
    }
    @IBAction func launchTranslator(_ sender: UIButton) {
        let tele = TelegramViewController();
        self.navigationController?.pushViewController(tele, animated: true);
        
    }
    @IBAction func launchReference(_ sender: UIButton) {
        let table = MorseReferenceTableViewController();
        self.navigationController?.pushViewController(table, animated: true);
    }

}
