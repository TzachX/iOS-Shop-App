//
//  MenuChoiceController.swift
//  CircusOfValues
//
//  Created by Tzach Cohen on 28/10/2017.
//  Copyright © 2017 Fink. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MenuChoiceController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var GetHeader = String()
    @IBOutlet weak var mainLabel: UILabel!
    var tableName: String?
    var products:[Product] = []
    @IBOutlet weak var productTable: UITableView!
    
    @IBAction func dismissView(_ sender: Any) {
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "Main") as! MainController
       self.navigationController?.pushViewController(VC, animated: true)
}
    func fetchProduct()
    {
        if(GetHeader == "Purchases")
        {
    Database.database().reference().child(GetHeader.lowercased()).child(DatabaseManager.manager.userId!).observe(DataEventType.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]
            {
            let product = Product(name: dictionary["name"] as? String, price: "\(dictionary["price"]!)$",imageURL: "\(dictionary["imageURL"]!))")
            self.products.append(product)
            DispatchQueue.main.async {
                self.productTable.reloadData()
            }
            }
        }
        }
        else
        {
            Database.database().reference().child(GetHeader.lowercased()).observe(DataEventType.childAdded) { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject]
                {
                    let product = Product(name: dictionary["name"] as? String, price: "\(dictionary["price"]!)$",imageURL: "\(dictionary["imageURL"]!))")
                    self.products.append(product)
                    DispatchQueue.main.async {
                        self.productTable.reloadData()
                    }
                }
            }
        }
}
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (products.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let productcellview = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCellView
        let product = products[indexPath.row]
        productcellview.productName.text = product.name
        productcellview.productPrice.text = product.price?.description
        productcellview.productImageURL? = product.imageURL!
        if let productImageURL = product.imageURL
        {
            productcellview.productImage.loadImageUsingCacheWithUrlString(productImageURL)
        }
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        productcellview.backgroundColor = UIColor(red: 50/250, green: 46/250, blue: 63/250, alpha: 1)
        productcellview.productName.textColor = UIColor(red: 244/250, green: 220/250, blue: 94/250, alpha: 1)
        productcellview.productPrice.textColor = UIColor(red: 244/250, green: 220/250, blue: 94/250, alpha: 1)

        return (productcellview)
    }
    
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //let choiceVC = storyBoard.instantiateViewController(withIdentifier: "MenuChoice") as! MenuChoiceController
        //choiceVC.GetHeader = list[indexPath.row]
        //self.navigationController?.pushViewController(choiceVC, animated: true)
    //}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = GetHeader
        fetchProduct()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
