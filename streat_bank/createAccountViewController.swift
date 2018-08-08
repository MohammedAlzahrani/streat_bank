//
//  createAccountViewController.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 28/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//
// this class is used to create an account

import UIKit

class createAccountViewController: UIViewController {
    
    let request = postRequest()
    var result: NSString = ""

    @IBOutlet weak var firstNameLable: UITextField!
    @IBOutlet weak var lastNameLable: UITextField!
    @IBOutlet weak var cityLable: UITextField!
    @IBOutlet weak var emailLable: UITextField!
    @IBOutlet weak var passwordLable: UITextField!
    @IBAction func submitButton(sender: AnyObject) {
        
        getDBcontent()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //myImageUploadRequest()
        
    }
    
    func getDBcontent(){
        
        let url = NSURL(string: "http://localhost/html/createAccount.php")!
        let firstName = firstNameLable.text
        let lastName = lastNameLable.text
        let city = cityLable.text
        let email = emailLable.text
        let password = passwordLable.text
        var postString = "firstName=" + firstName! +  "&lastName=" + lastName!
        postString = postString + "&city=" + city! + "&email=" + email!
        postString = postString + "&password=" + password!
        

        
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
}
