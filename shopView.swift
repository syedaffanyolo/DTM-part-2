//
//  shopView.swift
//  DTM
//
//  Created by Syedaffan on 11/15/20.
//

import UIKit

class shopView: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var shopTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // datasource and delgates for the shop tableview
        shopTable.dataSource = self
        shopTable.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func callbutton(_ sender: Any) {
        
        // here add the calling the shops functionality
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4 // harcoded cell numbers in row for testing
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shopTable.dequeueReusableCell(withIdentifier: "shopid", for: indexPath) as! shopCell // custom cell for shops
        
        
        
        // testing only in noida becasue we have data for logix city noida only rest regions and malls will be added as soon we get their data too
        if ViewController.myGlobalVar.region == "Noida"{// checking region
            
            switch Malls.importer.sender {// checking which mall is selected in that region
            case 0: // dlf mall
                print("lol") // no data so dummy code
            case 1: // logix mall (got the data for this one)
                if Malls.importer.floorsender == 0{ // checking which floor is clicked in this mall
                    cell.shopname.text = Malls.importer.lcshopnameslg![indexPath.row] // implementing the shops in the specif floord to the shop cells
                }else if Malls.importer.floorsender == 1{
                    cell.shopname.text = Malls.importer.lcshopnamesg![indexPath.row]
                }else if Malls.importer.floorsender == 2{
                    cell.shopname.text = Malls.importer.lcshopnames1![indexPath.row]
                }
            case 2:
                print("lol")
            case 3:
                print("lol")
                
            default:
                return UITableViewCell()
            }
        }
        
        
        
        return cell
    }
    
    
}
