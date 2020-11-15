//
//  GrNoida.swift
//  DTM
//
//  Created by Syedaffan on 8/24/20.
//

import UIKit


//node.js api
let url = "https://dtmappapi.herokuapp.com/data"


class Malls: UIViewController {
    
    //all variables here
    var imageArr : [Data]? = []
    // all buttons for malls
    @IBOutlet var cards: [UIButton]!
    //ui view on which the loader is placed
    @IBOutlet weak var loderView: UIView!
    // loader duh
    @IBOutlet weak var loder: UIActivityIndicatorView!
    //outlet for nav bar to change titles
    @IBOutlet weak var navBar: UINavigationItem!
    // scroll lenght changer so all button are hide and used when needed/ basically acesses the lenght feature /height of the view
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    // prefered light or dark = dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // getting api data back iwth rendering all styles
        // litereally rendering everytrhing here
        render(url: url)
        
    }
    
    //button actions
    
    @IBAction func bb(_ sender: UIButton) {
        // sets the value of the global variable sender to the current clicked button's sender.tag
        importer.sender = sender.tag
        //after setting value we perform the detailview segue and populate it with the right data
        performSegue(withIdentifier: "detail", sender: self)
        
        
    }
    
    // back swipe gesture action
    @IBAction func backswipe(_ sender: Any) {
        //performSegue(withIdentifier: "main", sender: (Any).self)
    }
    
    
    // big boss lies here
    func render(url:String){
        // starts animating our loader while the app gets all the relevent data we mention below now
        loder.startAnimating()
        
        navBar.title = ""
        // setting all the styles for our buttons
        for i in 0...15{
            cards[i].layer.cornerRadius = 10
            cards[i].titleLabel!.layer.shadowOffset = CGSize(width: 2.0, height: 2.0);
            cards[i].titleLabel!.layer.shadowRadius = 2.0;
            cards[i].titleLabel!.layer.shadowOpacity = 1.0;
            cards[i].titleLabel!.layer.masksToBounds = false;
        }
        // url session to get data back from the api into readable format
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else{
                print("somthin wrong")
                return
            }
            var result: grNoida?
            do {
                result = try JSONDecoder().decode(grNoida.self, from: data)
            } catch  {
                print(error)
            }
            
            guard let json = result else{
                
                return
            }
            // end of the request for api here
            
            // populating data on the button views!
            if ViewController.myGlobalVar.region == "Greater Noida"{
                // doing this on the main thread in necessary
                DispatchQueue.main.async { [self] in
                    
                    navBar.title = "Malls in Greater Noida"
                    // since we have four malls here so the relvant hight taken by the four cards will be 1200 rest 14 buttons will be hidden
                    viewHeight.constant = 1200
                    // here is where we hide the rest buttons because we dont need them unlees somone decide to make a new mall in greater noida lol
                    for i in 4...15{
                        cards[i].isHidden = true
                        cards[i].isEnabled = false
                    }
                    
                    /// grand venice
                    //setting title
                    self.cards[0].setTitle(json.gvname, for: .normal)
                    //converting the image string we got from the api to a url then data
                    let grvurl = URL(string: json.gvmallimage)!
                    if let datagr = try? Data(contentsOf: grvurl){
                        //setting the global variable to the image of this mall to be used in detailView,mall name,mall adress and the floor numbers
                        importer.gvdis = json.gvdis
                        importer.imagegrv = datagr
                        importer.gvfloors = json.gvfloors
                        importer.gvname = json.gvname
                        //setting the backgroung image as retrived data
                        self.cards[0].setBackgroundImage(UIImage(data: datagr), for: .normal)
                        
                    }
                    
                    /// msxmall
                    self.cards[1].setTitle(json.mmname, for: .normal)
                    let msxurl = URL(string: json.mmmallimage)!
                    if let datamm = try? Data(contentsOf: msxurl){
                        importer.msdis = json.mmdis
                        importer.imagemsx = datamm
                        importer.msfloors = json.mmfloors
                        importer.msname = json.mmname
                        self.cards[1].setBackgroundImage(UIImage(data: datamm), for: .normal)
                    }
                    
                    /// ansalplaza
                    self.cards[2].setTitle(json.apname, for: .normal)
                    let ansurl = URL(string: json.apmallimage)!
                    if let dataap = try? Data(contentsOf: ansurl){
                        importer.andis = json.apdis
                        importer.imageans = dataap
                        importer.anfloors = json.apfloors
                        importer.anname = json.apname
                        self.cards[2].setBackgroundImage(UIImage(data: dataap), for: .normal)
                    }
                    
                    ///omaxearcade
                    self.cards[3].setTitle(json.oaname, for: .normal)
                    let omxurl = URL(string: json.oamallimage)!
                    if let dataoa = try? Data(contentsOf: omxurl){
                        importer.oadis = json.oadis
                        importer.imageomx = dataoa
                        importer.omfloors = json.oafloors
                        importer.oaname = json.oaname
                        self.cards[3].setBackgroundImage(UIImage(data: dataoa), for: .normal)
                    }
                    //stop animating then hide the loader and uiview its on and its capabilites so that elemnts beind it are accessable , since we have retrieved all the data we need for this mall we can stop the loading stuff
                    self.loder.stopAnimating()
                    self.loder.isHidden = true
                    loder.isUserInteractionEnabled = false
                    loderView.isExclusiveTouch = false
                    loderView.isUserInteractionEnabled = false
                }
            }else if ViewController.myGlobalVar.region == "Noida"{
                // show noida stuff
                DispatchQueue.main.async {
                    
                    self.navBar.title = "Malls in Noida"
                    self.viewHeight.constant = 1200
                    for i in 4...15{
                        self.cards[i].isHidden = true
                        self.cards[i].isEnabled = false
                    }
                    
                    /// dlf mall
                    self.cards[0].setTitle(json.dmname, for: .normal)
                    let dmurl = URL(string: json.dmmallimage)!
                    
                    //print(lcfloorurl)
                    if let datadm = try? Data(contentsOf: dmurl){
                        importer.dmdis = json.dmdis
                        importer.imagedm = datadm
                        importer.dmfloors = json.dmfloors
                        importer.dmname = json.dmname
                        
                        self.cards[0].setBackgroundImage(UIImage(data: datadm), for: .normal)
                    }
                    
                    
                    
                    ///logix city
                    
                    
                    self.cards[1].setTitle(json.lcname, for: .normal)
                    let lcurl = URL(string: json.lcmallimage)!
                    if let datalc = try? Data(contentsOf: lcurl){
                        importer.lcdis = json.lcdis // mall addrss
                        importer.imagelc = datalc // mall image
                        importer.lcfloors = json.lcfloors // mall floors int
                        importer.lcfloornames = json.lcfloornames // malls floornames
                        importer.lcname = json.lcname // mall name
                        importer.lcfloorimg = json.lcfloorimages //getting all 3 url strings from json converted api
                        importer.lcshopnameslg = json.lcshopslg // shops in lower ground
                        importer.lcshopnamesg = json.lcshopg // shops in ground
                        importer.lcshopnames1 = json.lcshop1 // shops in 1st floor
                        importer.lcshopnames2 = json.lcshop2 // 2nd
                        importer.lcshopnames3 = json.lcshop3 // 3rd
                        importer.lcshopnames4 = json.lcshop4 // 4th
                        importer.phoneNumberslg = json.lcshopphone
                        self.cards[1].setBackgroundImage(UIImage(data: datalc), for: .normal)
                        
                    }
                    let lcfloorurl = [URL(string: json.lcfloorimages[0])!,URL(string: json.lcfloorimages[1])!,URL(string: json.lcfloorimages[2])!] // getting the hold of only one url string and coverting it into url and setting it to a var for testing.
                    for i in 0...2{ // getting one by one data from the array we make below
                        
                        if let imageData = try? Data(contentsOf: lcfloorurl[i]){
                            
                            
                            
                            self.imageArr?.append(imageData) // appending the data to our image array we made in starting of the file
                            
                            
                        }
                        
                    }
                    
                    importer.dataFloorLc = self.imageArr // setting the value of our global [var] to our nely ready image array
                    
                    
                    
                    
                    
                    self.cards[2].setTitle(json.ggname, for: .normal)
                    let ggurl = URL(string: json.ggmallimage)!
                    if let datagg = try? Data(contentsOf: ggurl){
                        importer.ggdis = json.ggdis
                        importer.imagegg = datagg
                        importer.ggfloors = json.ggfloors
                        importer.ggname = json.ggname
                        self.cards[2].setBackgroundImage(UIImage(data: datagg), for: .normal)
                        
                    }
                    
                    self.cards[3].setTitle(json.gpname, for: .normal)
                    let gpurl = URL(string: json.gpmallimage)!
                    if let datagp = try? Data(contentsOf: gpurl){
                        importer.gpdis = json.gpdis
                        importer.imagegp = datagp
                        importer.gpfloors = json.gpfloors
                        importer.gpname = json.gpname
                        self.cards[3].setBackgroundImage(UIImage(data: datagp), for: .normal)
                    }
                    self.loder.stopAnimating()
                    self.loder.isHidden = true
                    self.loder.isUserInteractionEnabled = false
                    self.loderView.isExclusiveTouch = false
                    self.loderView.isUserInteractionEnabled = false
                }
            }else if ViewController.myGlobalVar.region == "Delhi"{
                //delhi stuff here
                
                DispatchQueue.main.async {
                    
                    self.navBar.title = "Malls in Delhi"
                    // eight malls definetly needs more scrollable lenght thats why we increased it to 2400 sice its the double of 4 (1200+1200 = 2400)
                    self.viewHeight.constant = 2400
                    
                    for i in 8...15{
                        self.cards[i].isHidden = true
                        self.cards[i].isEnabled = false
                    }
                    /// dlf mall
                    self.cards[0].setTitle(json.vsname, for: .normal)
                    let vsurl = URL(string: json.vsmallimage)!
                    if let datavs = try? Data(contentsOf: vsurl){
                        importer.vsdis = json.vsdis
                        importer.imagevs = datavs
                        importer.vsfloors = json.vsfloors
                        importer.vsname = json.vsname
                        self.cards[0].setBackgroundImage(UIImage(data: datavs), for: .normal)
                    }
                    
                    self.cards[1].setTitle(json.tcname, for: .normal)
                    let tcurl = URL(string: json.tcmallimage)!
                    if let datatc = try? Data(contentsOf: tcurl){
                        importer.tcdis = json.tcdis
                        importer.imagetc = datatc
                        importer.tcfloors = json.tcfloors
                        importer.tcname = json.tcname
                        self.cards[1].setBackgroundImage(UIImage(data: datatc), for: .normal)
                        
                    }
                    
                    self.cards[2].setTitle(json.ccname, for: .normal)
                    let ccurl = URL(string: json.ccmallimage)!
                    if let datacc = try? Data(contentsOf: ccurl){
                        importer.ccdis = json.ccdis
                        importer.imagecc = datacc
                        importer.ccfloors = json.ccfloors
                        importer.ccname = json.ccname
                        self.cards[2].setBackgroundImage(UIImage(data: datacc), for: .normal)
                        
                    }
                    
                    self.cards[3].setTitle(json.cmname, for: .normal)
                    let cmurl = URL(string: json.cmmallimage)!
                    if let datacm = try? Data(contentsOf: cmurl){
                        importer.cmdis = json.cmdis
                        importer.imagecm = datacm
                        importer.cmfloors = json.cmfloors
                        importer.cmname = json.cmname
                        self.cards[3].setBackgroundImage(UIImage(data: datacm), for: .normal)
                    }
                    
                    self.cards[4].setTitle(json.dsname, for: .normal)
                    let dsurl = URL(string: json.dsmallimage)!
                    if let datads = try? Data(contentsOf: dsurl){
                        importer.dsdis = json.dsdis
                        importer.imageds = datads
                        importer.dsfloors = json.dsfloors
                        importer.dsname = json.dsname
                        self.cards[4].setBackgroundImage(UIImage(data: datads), for: .normal)
                    }
                    
                    self.cards[5].setTitle(json.amname, for: .normal)
                    let amurl = URL(string: json.ammallimage)!
                    if let dataam = try? Data(contentsOf: amurl){
                        importer.amdis = json.amdis
                        importer.imageam = dataam
                        importer.amfloors = json.amfloors
                        importer.amname = json.amname
                        self.cards[5].setBackgroundImage(UIImage(data: dataam), for: .normal)
                        
                    }
                    
                    self.cards[6].setTitle(json.pmname, for: .normal)
                    let pmurl = URL(string: json.pmmallimage)!
                    if let datapm = try? Data(contentsOf: pmurl){
                        importer.pmdis = json.pmdis
                        importer.imagepm = datapm
                        importer.pmfloors = json.pmfloors
                        importer.pmname = json.pmname
                        self.cards[6].setBackgroundImage(UIImage(data: datapm), for: .normal)
                        
                    }
                    
                    self.cards[7].setTitle(json.scname, for: .normal)
                    let scurl = URL(string: json.scmallimage)!
                    if let datasc = try? Data(contentsOf: scurl){
                        importer.scdis = json.scdis
                        importer.imagesc = datasc
                        importer.scfloors = json.scfloors
                        importer.scname = json.scname
                        self.cards[7].setBackgroundImage(UIImage(data: datasc), for: .normal)
                    }
                    self.loder.stopAnimating()
                    self.loder.isHidden = true
                    self.loder.isUserInteractionEnabled = false
                    self.loderView.isExclusiveTouch = false
                    self.loderView.isUserInteractionEnabled = false
                }
                
            }
            
            
        })
        // here is where we resume our networking i think maybe ignore this or maybe this the reason why we taking so much time to render SHOULD LOOK INTO THAT PROBLEM MAYBE THIS RELEVANT
        task.resume()
        
        
        
        
        
    }
    // global variables for the detail view we have
    struct importer {
        // global sender.tag
        static var sender : Int? = nil
        // global floorsender.tag
        static var floorsender : Int? = nil
        // global zoomsender.tag
        static var zoomsender : Int? = nil
        //global callsender.tag
        static var callsender : Int? = nil
        //gr noida
        static var imagegrv : Data? = nil
        static var imageomx : Data? = nil
        static var imageans : Data? = nil
        static var imagemsx : Data? = nil
        static var gvfloors : Int? = nil
        static var omfloors : Int? = nil
        static var anfloors : Int? = nil
        static var msfloors : Int? = nil
        static var gvname :String? = nil
        static var msname :String? = nil
        static var anname :String? = nil
        static var oaname :String? = nil
        static var gvdis : String? = nil
        static var msdis : String? = nil
        static var andis : String? = nil
        static var oadis : String? = nil
        
        
        //noida
        static var imagedm : Data? = nil
        static var dataFloorLc : [Data]? = nil // array contains all the floors in lc i.e. logix city noida
        static var phoneNumberslg : [Int]? = nil
        static var phoneNumbersg : [Int]? = nil
        static var phoneNumbers1 : [Int]? = nil
        static var imagelc : Data? = nil
        static var imagegg : Data? = nil
        static var imagegp : Data? = nil
        static var lcfloors : Int? = nil
        static var ggfloors : Int? = nil
        static var gpfloors : Int? = nil
        static var dmfloors : Int? = nil
        static var dmname :String? = nil
        static var lcname :String? = nil
        static var ggname :String? = nil
        static var gpname :String? = nil
        static var dmdis : String? = nil
        static var lcdis : String? = nil
        static var ggdis : String? = nil
        static var gpdis : String? = nil
        static var lcfloorimg : [String]? = nil
        static var lcfloornames : [String]? = nil
        static var lcshopnameslg : [String]? = nil
        static var lcshopnamesg : [String]? = nil
        static var lcshopnames1 : [String]? = nil
        static var lcshopnames2 : [String]? = nil
        static var lcshopnames3: [String]? = nil
        static var lcshopnames4 : [String]? = nil
        
        
        //delhi
        static var imagevs : Data? = nil
        static var imagetc : Data? = nil
        static var imagecc : Data? = nil
        static var imagecm : Data? = nil
        static var imageds : Data? = nil
        static var imageam : Data? = nil
        static var imagepm : Data? = nil
        static var imagesc : Data? = nil
        static var vsfloors : Int? = nil
        static var tcfloors : Int? = nil
        static var ccfloors : Int? = nil
        static var cmfloors : Int? = nil
        static var dsfloors : Int? = nil
        static var amfloors : Int? = nil
        static var pmfloors : Int? = nil
        static var scfloors : Int? = nil
        static var vsname :String? = nil
        static var tcname :String? = nil
        static var ccname :String? = nil
        static var cmname :String? = nil
        static var dsname :String? = nil
        static var amname :String? = nil
        static var pmname :String? = nil
        static var scname :String? = nil
        static var vsdis : String? = nil
        static var tcdis : String? = nil
        static var ccdis : String? = nil
        static var cmdis : String? = nil
        static var dsdis : String? = nil
        static var amdis : String? = nil
        static var pmdis : String? = nil
        static var scdis : String? = nil
        
        
    }
    
}

