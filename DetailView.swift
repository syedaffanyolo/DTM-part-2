//
//  DetailView.swift
//  DTM
//
//  Created by Syedaffan on 10/25/20.
//

import UIKit

class DetailView: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    
// all outlets
    

    
    
    @IBOutlet weak var detailTable: UITableView!
    @IBOutlet weak var navigation: UIButton!
    @IBOutlet weak var dislabel: UILabel!
    @IBOutlet weak var mallimage: UIImageView!
    
    var shopnumbercell : Int? = nil // cell amount variable to be used later
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting delgate and data source for our table view
        detailTable.delegate = self
        detailTable.dataSource = self
       //rendering all the detail for the selcted mall while the detail seque starts at first
       render()
       
    }
    // navigation/map action
    @IBAction func navigationButton(_ sender: Any) {
    }
    // big boss 2 lies here
    func render(){
        //checking selected region
        // like here we check foro grnoida and we know we got 4 malls , since we are having reusable buttons we cant assign them all in one so we have to check what region we are in and then populating the data of the mall we selcted from that region
        if ViewController.myGlobalVar.region == "Greater Noida"{
            // the switch statement here is an integer it is the sender.tag global variable
            switch Malls.importer.sender {
        //if the sender.tag was 0..3 do this
        case 0:// on zero tag we know its grand venice hence we do the following stuff
            mallimage.image = UIImage(data: Malls.importer.imagegrv!)//gr venice data holidng image
            shopnumbercell = Malls.importer.gvfloors // setting floors for this mall in a variable so that it could be used in cell amount proptional to floors
        case 1:
            mallimage.image = UIImage(data: Malls.importer.imagemsx!)
            shopnumbercell = Malls.importer.msfloors
        case 2:
            mallimage.image = UIImage(data: Malls.importer.imageans!)
            shopnumbercell = Malls.importer.anfloors
        case 3:
            mallimage.image = UIImage(data: Malls.importer.imageomx!)
            shopnumbercell = Malls.importer.omfloors
        default:
            return
        }
        }else if ViewController.myGlobalVar.region == "Noida"{
            switch Malls.importer.sender {
            case 0:
                mallimage.image = UIImage(data: Malls.importer.imagedm!)
                shopnumbercell = Malls.importer.dmfloors
            case 1:
                mallimage.image = UIImage(data: Malls.importer.imagelc!)
                shopnumbercell = Malls.importer.lcfloors
            case 2:
                mallimage.image = UIImage(data: Malls.importer.imagegg!)
                shopnumbercell = Malls.importer.ggfloors
            case 3:
                mallimage.image = UIImage(data: Malls.importer.imagegp!)
                shopnumbercell = Malls.importer.gpfloors
            default:
                return
            }
            
            
        }else if ViewController.myGlobalVar.region == "Delhi"{
            
            switch Malls.importer.sender {
            case 0:
                mallimage.image = UIImage(data: Malls.importer.imagevs!)
                shopnumbercell = Malls.importer.vsfloors
            case 1:
                mallimage.image = UIImage(data: Malls.importer.imagetc!)
                shopnumbercell = Malls.importer.tcfloors
            case 2:
                mallimage.image = UIImage(data: Malls.importer.imagecc!)
                shopnumbercell = Malls.importer.ccfloors
            case 3:
                mallimage.image = UIImage(data: Malls.importer.imagecm!)
                shopnumbercell = Malls.importer.cmfloors
            case 4:
                mallimage.image = UIImage(data: Malls.importer.imageds!)
                shopnumbercell = Malls.importer.dsfloors
            case 5:
                mallimage.image = UIImage(data: Malls.importer.imageam!)
                shopnumbercell = Malls.importer.amfloors
            case 6:
                mallimage.image = UIImage(data: Malls.importer.imagepm!)
                shopnumbercell = Malls.importer.pmfloors
            case 7:
                mallimage.image = UIImage(data: Malls.importer.imagesc!)
                shopnumbercell = Malls.importer.scfloors
            default:
                return
            }
            
        }
        
    }
    //table view stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shopnumbercell! // amount of cells to be presented  = floors in mall
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! floorCell // custom cell
             //  cell.backgroundColor = UIColor.systemRed
        
               return cell
    }
}
