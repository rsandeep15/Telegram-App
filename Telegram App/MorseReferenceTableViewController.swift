//
//  MorseReferenceTableViewController.swift
//  Telegram App
//
//  Created by Sandeep on 11/18/16.
//  Copyright © 2016 Sandeep. All rights reserved.
//

import UIKit

class MorseReferenceTableViewController: UITableViewController{
    
    var morse: MorseCode!;
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil);
        let nav = UINavigationItem();
        nav.title="Morse Reference";
        morse = MorseCode();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier");
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (morse?.characters?.count)!;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        let index = indexPath.row;
        let cellText = String(describing: morse.characters[index]) + "\t" + String(describing: morse.morseCodes[index]);
        cell.textLabel?.text = cellText;
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Morse Code Reference"; 
    }


}
