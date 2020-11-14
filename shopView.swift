//
//  shopView.swift
//  DTM
//
//  Created by Syedaffan on 11/15/20.
//

import UIKit

class shopView: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    
    @IBOutlet weak var shopTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopTable.dataSource = self
        shopTable.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func callbutton(_ sender: Any) {
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shopTable.dequeueReusableCell(withIdentifier: "shopid", for: indexPath) as! shopCell // custom cell
        
        
        
        
         if ViewController.myGlobalVar.region == "Noida"{
            
            switch Malls.importer.sender {
            case 0:
                print("lol")
            case 1:
                if Malls.importer.floorsender == 0{
                cell.shopname.text = Malls.importer.lcshopnameslg![indexPath.row]
                }else if Malls.importer.floorsender == 1{
                    cell.shopname.text = Malls.importer.lcshopnamesg![indexPath.row]
                }else{
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
