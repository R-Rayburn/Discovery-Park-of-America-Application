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
    var item: Item!
    //@IBOutlet var bgImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //print(item.name)
                
        nameLabel.text = item.name
        infoText.text = item.info
        self.view.backgroundColor = UIColor(patternImage: item.image)
        
        //infoText.contentSize.height = 1000
        infoText.translatesAutoresizingMaskIntoConstraints = true
        //infoText.sizeToFit()
        //infoText.contentOffset.x = 50
        //infoText.contentOffset.y = 50
        //infoText.contentInset = UIEdgeInsetsMake(0, 10.0, 0, 10.0)
        infoText.isScrollEnabled = true
        
        
        //bgImage.alpha = 0.4
    }

}
