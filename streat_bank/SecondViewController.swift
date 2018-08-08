//
//  SecondViewController.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 24/08/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//
// this class is used to display information about a particular item that the user has clicked on

import UIKit

class SecondViewController: UIViewController {
    
    let request = postRequest()
    var result: NSString = ""

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var ownerLable: UILabel!
    @IBOutlet weak var locationLable: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBAction func sendRequest(sender: AnyObject) {
        
        getDBcontent()
    }

    
    @IBAction func showOnMap(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // display larg view for item when clicked on
        //nameLable.text = cellContent[activeItem]
        nameLable.text = jsonArray[activeItem]["name"]! as? String
        //descriptionLable.text = descri[activeItem]
        descriptionLable.text = jsonArray[activeItem]["description"]! as? String
        photoView.image = images[activeItem]
        priceLable.text = jsonArray[activeItem]["price"]! as? String
        ownerLable.text = jsonArray[activeItem]["firstName"]! as? String
        locationLable.text = jsonArray[activeItem]["city"]! as? String
        
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == UIEventSubtype.MotionShake {
            
            getDBcontent()
        
        }
    }
    
    func getDBcontent(){
        let url = NSURL(string: "http://localhost/html/requestItem.php")!
        var postString = "userID=" + String(userID) + "&"
        postString = postString + "itemID=" + String(jsonArray[activeItem]["itemID"]!) + "&"
        postString = postString + "ownerID=" + String(jsonArray[activeItem]["myOwnerID"]!)
        
        
        
        //let postString = "userID=2&itemID=555&ownerID=1"
        
        request.getResponse(url, postingString: postString) {
            content in
            dispatch_async(dispatch_get_main_queue()) {
                
                
                self.result = content
                var resultTitle = ""
                var resultMessage = ""
                if(self.result == "success"){
                resultTitle = "successful request"
                resultMessage = "your request successfully sent"
                }
                
                else{
                 resultTitle = "error"
                 resultMessage = "your request was not sent. Please try again!"
                }
                
                let alert = UIAlertController(title: resultTitle, message: resultMessage, preferredStyle: UIAlertControllerStyle.Alert)

                alert.addAction(UIAlertAction(title: "Done", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let mapView : mapViewController = segue.destinationViewController as! mapViewController
        mapView.lat = (jsonArray[activeItem]["lat"] as! NSString).doubleValue
        mapView.long = (jsonArray[activeItem]["longt"] as! NSString).doubleValue
        mapView.locationTitle = jsonArray[activeItem]["name"] as! NSString as String
        
    }
    
    
}
