//
//  AddItemViewController.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 24/08/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//
// this class is used to add new item to the database

import UIKit
import CoreLocation

class AddItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var lat = ""
    var long = ""
    let request = postRequest()
    let coordinateRequest = Address2coordinate()
    var result: NSString = ""
    
    @IBOutlet weak var nameLable: UITextField!
    @IBOutlet weak var DescriptionLable: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var addressLable: UITextField!
   
    @IBOutlet weak var importImageButton: UIButton!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var importedImage: UIImageView!
    
    // choose image from photo library
    @IBAction func importImage(sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    // display selected image in imageview
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        importedImage.image = image
        importImageButton.hidden = true
    }
    
    // add new item
    @IBAction func AddItemButton(sender: AnyObject) {
        
        //cellContent.append(nameLable.text!)
        //descri.append(DescriptionLable.text!)
        //images.append(importedImage.image!)
        getAddress()
//        getDBcontent()
//       myImageUploadRequest()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //myImageUploadRequest()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAddress(){
        let address = addressLable.text!
        coordinateRequest.getCoordinate(address){ (cityCoordinate: CLLocationCoordinate2D) -> () in
            //let ss = cityCoordinate
            let kkk = cityCoordinate
            dispatch_async(dispatch_get_main_queue()) {
                self.lat = String(kkk.latitude)
                self.long = String(kkk.longitude)
                
//                print(kkk.latitude)
//                print("ffdg")
                self.getDBcontent()
                self.myImageUploadRequest()
            }
            
        }
    
    }
    
    func getDBcontent(){
        
        let url = NSURL(string: "http://localhost/html/addItem.php")!
        let name = nameLable.text
        let description = DescriptionLable.text
        let lat = self.lat
        let longt = self.long
        let image = nameLable.text! + ".jpg"
        let price = priceLabel.text
        let myOwnerID = userID
        var postString = "name=" + name! +  "&description=" + description!
        //var postString = "name=" + name! +  "&description=" + location
        postString = postString + "&lat=" + lat + "&longt=" + longt + "&image=" + image
        postString = postString + "&price=" + price!
        postString = postString + "&myOwnerID=" + String(myOwnerID)
        
        print(postString)
        
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
    
    // this code is takien from http://swiftdeveloperblog.com/image-upload-example/
    
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string: "http://localhost/html/uploadImage2.php");
        
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = [

            "userId"    : "0"
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(importedImage.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        
        myActivityIndicator.startAnimating();
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                
                print(json)
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.myActivityIndicator.stopAnimating()
                    self.importedImage.image = nil;
                });
                
            }catch
            {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        //let filename = "user-profile.jpg"
        let filename = nameLable.text! + ".jpg"
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}


