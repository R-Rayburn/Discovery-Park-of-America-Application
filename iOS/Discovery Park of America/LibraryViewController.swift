//
//  LibraryViewController.swift
//  Discovery Park of America
//
//  Created by Paul Gosser on 9/15/17.
//  Copyright © 2017 Paul Gosser. All rights reserved.
//

import UIKit

class LibraryViewController: UITableViewController {
    var itemStore: ItemStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath) as! LibraryCell
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "LibraryCell")
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]
        
        // Configure the cell with the item
        //cell.nameLabel.text = item.name
        //cell.textLabel?.text = item.name
        cell.name.text = item.name
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 75
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showInfo"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let descriptionViewController = segue.destination as! DescriptionViewController
                descriptionViewController.item = item
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
