//
//  DescriptionView Controller.swift
//  Discovery Park of America
//
//  Created by Paul Gosser on 9/8/17.
//  Copyright © 2017 Paul Gosser. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var infoText: UITextView!
    @IBOutlet var imageView: UIImageView!
    var item: Item!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //print(item.name)
                
        nameLabel.text = item.name
        infoText.text = item.info
        //self.view.backgroundColor = UIColor(patternImage: item.image)
        imageView.image = item.image
        
        infoText.translatesAutoresizingMaskIntoConstraints = true
        infoText.isScrollEnabled = true
        infoText.showsVerticalScrollIndicator = false
        
        //infoText.layer.borderWidth = 5.0
    }

}
