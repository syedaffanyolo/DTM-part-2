//
//  floorCell.swift
//  DTM
//
//  Created by Syedaffan on 11/1/20.
//

import UIKit
import Foundation

class floorCell: UITableViewCell {
//outlets
    @IBOutlet weak var floorButton: UIButton!
    @IBOutlet weak var floorName: UILabel!
    @IBOutlet weak var shopButton: UIButton!
    
    
    
    //mapfloorbutton
    @IBAction func floorButtonClicked(_ sender: Any) {
        print("clicked")
    }
    // shopsnextbutton
    @IBAction func shopsButton(_ sender: Any) {
      //  Malls.importer.floorsender = shopButton.sender.tag
        
        //print(Malls.importer.floorsender)
        // print("hereyougo\(Malls.importer.floorsender)")
    }
}
