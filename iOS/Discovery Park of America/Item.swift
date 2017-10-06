//
//  Item.swift
//  Discovery Park of America
//
//  Created by Paul Gosser on 9/15/17.
//  Copyright © 2017 Paul Gosser. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var info: String
    var image: UIImage
    
    init(name: String, info: String, picture: String){
        self.name = name
        self.info = info
        self.image = UIImage(named: picture)!
        
        super.init()
    }
    
    override init() {
        self.name = "Exhibit"
        self.info = "This is the desciption for the exhibit. " +
                    "It will show up in paragraph form here before the name. " +
                    "We will eventually format this area to contain a picture or some other design. "
        self.image = UIImage(named: "Energy")!
        
    }
}
