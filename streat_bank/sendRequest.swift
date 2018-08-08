//
//  sendRequest.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 20/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

import Foundation

class postRequest {
    
    
    var response : NSString = ""

    func getResponse(url: NSURL, postingString: String,completionHandler: (content: NSString) -> ()) {
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        let postString = postingString
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            
            if let urlContent = data{
                
                self.response = NSString(data: urlContent, encoding: NSUTF8StringEncoding)!
                completionHandler(content: self.response)
                
                
            }
            
        }
        
        task.resume()
        
        
    }
}