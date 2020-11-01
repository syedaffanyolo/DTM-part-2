//
//  DetailView.swift
//  DTM
//
//  Created by Syedaffan on 10/25/20.
//

import UIKit
import MapKit


class DetailView: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    
    // all outlets
    
    
    
    @IBOutlet weak var navBar: UINavigationItem!
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
        //giving address to the mapkit to the value of the current value of dislabel
        coordinates(forAddress: dislabel.text!) {
            (location) in
            guard let location = location else {
                // Handle error here.
                return
            }
            //opening the directions for that location
            self.openMapForPlace(lat: location.latitude, long: location.longitude)
        }
        
    }
    // big boss 2 lies here
    func render(){
        //setting nav bar title to empty
        navBar.title = ""
        //checking selected region
        // like here we check foro grnoida and we know we got 4 malls , since we are having reusable buttons we cant assign them all in one so we have to check what region we are in and then populating the data of the mall we selcted from that region
        if ViewController.myGlobalVar.region == "Greater Noida"{
            // the switch statement here is an integer it is the sender.tag global variable
            switch Malls.importer.sender {
            //if the sender.tag was 0..3 do this
            case 0:// on zero tag we know its grand venice hence we do the following stuff
                //setting nav title
                navBar.title = Malls.importer.gvname //setting navbar title to the mall name
                dislabel.text = Malls.importer.gvdis //setting address to mall address
                mallimage.image = UIImage(data: Malls.importer.imagegrv!)//gr venice data holidng image
                shopnumbercell = Malls.importer.gvfloors // setting floors for this mall in a variable so that it could be used in cell amount proptional to floors
            case 1:
                navBar.title = Malls.importer.msname
                dislabel.text = Malls.importer.msdis
                mallimage.image = UIImage(data: Malls.importer.imagemsx!)
                shopnumbercell = Malls.importer.msfloors
            case 2:
                navBar.title = Malls.importer.anname
                dislabel.text = Malls.importer.andis
                mallimage.image = UIImage(data: Malls.importer.imageans!)
                shopnumbercell = Malls.importer.anfloors
            case 3:
                navBar.title = Malls.importer.oaname
                dislabel.text = Malls.importer.oadis
                mallimage.image = UIImage(data: Malls.importer.imageomx!)
                shopnumbercell = Malls.importer.omfloors
            default:
                return
            }
        }else if ViewController.myGlobalVar.region == "Noida"{
            switch Malls.importer.sender {
            case 0:
                navBar.title = Malls.importer.dmname
                dislabel.text = Malls.importer.dmdis
                mallimage.image = UIImage(data: Malls.importer.imagedm!)
                shopnumbercell = Malls.importer.dmfloors
            case 1:
                navBar.title = Malls.importer.lcname
                dislabel.text = Malls.importer.lcdis
                mallimage.image = UIImage(data: Malls.importer.imagelc!)
                shopnumbercell = Malls.importer.lcfloors
            case 2:
                navBar.title = Malls.importer.ggname
                dislabel.text = Malls.importer.ggdis
                mallimage.image = UIImage(data: Malls.importer.imagegg!)
                shopnumbercell = Malls.importer.ggfloors
            case 3:
                navBar.title = Malls.importer.gpname
                dislabel.text = Malls.importer.gpdis
                mallimage.image = UIImage(data: Malls.importer.imagegp!)
                shopnumbercell = Malls.importer.gpfloors
            default:
                return
            }
            
            
        }else if ViewController.myGlobalVar.region == "Delhi"{
            
            switch Malls.importer.sender {
            case 0:
                navBar.title = Malls.importer.vsname
                dislabel.text = Malls.importer.vsdis
                mallimage.image = UIImage(data: Malls.importer.imagevs!)
                shopnumbercell = Malls.importer.vsfloors
            case 1:
                navBar.title = Malls.importer.tcname
                dislabel.text = Malls.importer.tcdis
                mallimage.image = UIImage(data: Malls.importer.imagetc!)
                shopnumbercell = Malls.importer.tcfloors
            case 2:
                navBar.title = Malls.importer.ccname
                dislabel.text = Malls.importer.ccdis
                mallimage.image = UIImage(data: Malls.importer.imagecc!)
                shopnumbercell = Malls.importer.ccfloors
            case 3:
                navBar.title = Malls.importer.cmname
                dislabel.text = Malls.importer.cmdis
                mallimage.image = UIImage(data: Malls.importer.imagecm!)
                shopnumbercell = Malls.importer.cmfloors
            case 4:
                navBar.title = Malls.importer.dsname
                dislabel.text = Malls.importer.dsdis
                mallimage.image = UIImage(data: Malls.importer.imageds!)
                shopnumbercell = Malls.importer.dsfloors
            case 5:
                navBar.title = Malls.importer.amname
                dislabel.text = Malls.importer.amdis
                mallimage.image = UIImage(data: Malls.importer.imageam!)
                shopnumbercell = Malls.importer.amfloors
            case 6:
                navBar.title = Malls.importer.pmname
                dislabel.text = Malls.importer.pmdis
                mallimage.image = UIImage(data: Malls.importer.imagepm!)
                shopnumbercell = Malls.importer.pmfloors
            case 7:
                navBar.title = Malls.importer.scname
                dislabel.text = Malls.importer.scdis
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
    // function to turn string type address to a geolocation for directions in map
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    //func to open map app with the selected location , mapkit takes coordinated not as string address but as lat and lon so we convert our adress to geolocation previosly and later when we mention this function we put them in place of lat and lon rather than giving a line of address(its how mapkit knows where is the loaction)
    public func openMapForPlace(lat:Double = 0, long:Double = 0, placeName:String = "") {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        
        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: options)
    }
    
}
