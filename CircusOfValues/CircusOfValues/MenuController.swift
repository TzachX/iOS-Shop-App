//
//  MenuController.swift
//  CircusOfValues
//
//  Created by Tzach Cohen on 28/10/2017.
//  Copyright © 2017 Fink. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTable: UITableView!
    let list = ["Guns","Vigors","Purchases"]
    let imageList = [#imageLiteral(resourceName: "Grand_Largesse"),#imageLiteral(resourceName: "Raising_the_Bar_trophy"),#imageLiteral(resourceName: "BASLootIcon20")]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellview = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellView
        cellview.cellImage.image = imageList[indexPath.row]
        cellview.cellLabel.text = list[indexPath.row]
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cellview.backgroundColor = UIColor(red: 50/250, green: 46/250, blue: 63/250, alpha: 1)
        cellview.cellLabel.textColor = UIColor(red: 244/250, green: 220/250, blue: 94/250, alpha: 1)
        return (cellview)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let choiceVC = storyBoard.instantiateViewController(withIdentifier: "MenuChoice") as! MenuChoiceController
        choiceVC.GetHeader = list[indexPath.row]
        self.navigationController?.pushViewController(choiceVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
