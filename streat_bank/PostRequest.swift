//
//  getMyItems.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 15/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

import Foundation


class httpPostRequest {
    
    
    var myNewDictArray: [Dictionary<String, AnyObject>] = []
    // Do any additional setup after loading the view, typically from a nib.
    
    //private let url = NSURL(string: "http://localhost/html/sss.php")!
    
    
    //func getdbContent()-> Array<Dictionary<String, String>>{
    func getResponse(url: NSURL, postingString: String,completionHandler: (content: Array<Dictionary<String, AnyObject>>) -> ()) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        //let postString = "myOwnerID=2"
        let postString = postingString
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            
            if let urlContent = data{
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    
                    
                    self.myNewDictArray = json as! [Dictionary<String, AnyObject>]
                    completionHandler(content: self.myNewDictArray)
                    
                    
                    
                }
                catch {
                    
                    print("error")
                }
                
                
            }
            
        }
        
        task.resume()
        
        
    }
}