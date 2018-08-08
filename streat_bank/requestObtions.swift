//
//  requestObtions.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 20/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit

class requestObtions: UIViewController {
    let request = postRequest()
    let requestsToMe = RequestsToMeTableViewController()
    
        var result: NSString = ""
    

    @IBAction func accept(sender: AnyObject) {
        if(loggedin == true){
            getDBcontent("accept")}
    }

    @IBAction func reject(sender: AnyObject) {
        if(loggedin == true){
            getDBcontent("reject")}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDBcontent(action: String){
        let url1 = NSURL(string: "http://localhost/html/acceptRequest.php")!
        let url2 = NSURL(string: "http://localhost/html/rejectRequest.php")!
        var postString = ""
        var url = NSURL()
        
        var postString1 = "userID=" + String(userID) + "&"
        postString1 = postString1 + "itemID=" + String(requestsToMeArray[activeItem2]["itemID"]!) + "&"
        postString1 = postString1 + "requestID=" + String(requestsToMeArray[activeItem2]["requestID"]!)
        
        var postString2 = "requestID="
        postString2 = postString2 + String(requestsToMeArray[activeItem2]["requestID"]!)
        
        
        if(action=="accept"){
            url = url1
            postString = postString1
        }
        else if(action=="reject"){
            url = url2
            postString = postString2
        
        }
        
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
