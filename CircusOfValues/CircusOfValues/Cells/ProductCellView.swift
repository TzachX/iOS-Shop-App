//
//  ProductCellView.swift
//  CircusOfValues
//
//  Created by Tzach Cohen on 28/10/2017.
//  Copyright © 2017 Fink. All rights reserved.
//

import UIKit

class ProductCellView: UITableViewCell {
    
    @IBAction func productBuy(_ sender: Any) {
        DatabaseManager.manager.storePurchase(productName: productName.text, productPrice: productPrice.text, productImageURL: productImageURL)
    }
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var productImageURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
