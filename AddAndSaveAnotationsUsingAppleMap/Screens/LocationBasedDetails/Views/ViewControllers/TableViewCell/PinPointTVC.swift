//
//  PinPointTVC.swift
//  AddAndSaveAnotationsUsingAppleMap
//
//  Created by Faseeh PM on 17/01/25.
//

import UIKit

class PinPointTVC: UITableViewCell {

    @IBOutlet weak var btnDeletePinDetails: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadPinDetails(pin: PinPoint?){
        if let pinPoint = pin{
            lblTitle.text = pin?.title
            lblDescription.text = """
                                  \(pinPoint.description)
                                  Lat: \(pinPoint.latitude)
                                  Long: \(pinPoint.longitude)
                                  """
        }
        
    }
    
}
