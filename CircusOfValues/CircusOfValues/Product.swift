//
//  Product.swift
//  CircusOfValues
//
//  Created by Tzach Cohen on 28/10/2017.
//  Copyright © 2017 Fink. All rights reserved.
//

import Foundation
import UIKit

class Product: NSObject{
    var name: String?
    var price: String?
    var imageURL: String?
    
    init(name: String?, price: String?, imageURL: String?)
    {
        self.name = name
        self.price = price
        self.imageURL = imageURL
    }
}
