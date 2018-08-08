//
//  LoginViewController.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 21/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit
var loggedin = false
class LoginViewController: UIViewController {
    let request = postRequest()
    var result = ""

    @IBOutlet weak var emailLable: UITextField!
    @IBOutlet weak var passwordLable: UITextField!
    
    @IBAction func logout(sender: AnyObject) {
        loggedin = false
        //NSUserDefaults.standardUserDefaults().setObject(loggedin, forKey: "lg")
        userID = -1
        requestsToMeArray.removeAll()
        myRequestArray.removeAll()
        jsonArray.removeAll()
        jsonArray2.removeAll()
        
        myBorrowedItemsArray.removeAll()
        
        images.removeAll()
        images2.removeAll()
        images3.removeAll()
        images4.removeAll()
        images5.removeAll()
        
        print("logged out")

    }
    @IBAction func loginLable(sender: AnyObject) {
        if(self.emailLable.text != "" && self.passwordLable.text != ""){
        getDBcontent()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDBcontent(){
        let url = NSURL(string: "http://localhost/html/userLogin.php")!
        
        
        let postString = "email=" + self.emailLable.text! + "&password=" + self.passwordLable.text!
        

        
        request.getResponse(url, postingString: postString) {
            content in
            dispatch_async(dispatch_get_main_queue()) {
                
                
                self.result = content as String
                if(self.result=="wrong"){}
                else{
                userID = Int(self.result)!
                   loggedin = true
                    NSUserDefaults.standardUserDefaults().setObject(loggedin, forKey: "lg")
                    print("logged in")
                //self.performSegueWithIdentifier("loggedin", sender: nil)
                }

                
            }
            
        }
        
    }


}
