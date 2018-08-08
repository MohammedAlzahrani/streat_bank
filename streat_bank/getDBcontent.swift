//
//  getDBcontent.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 1/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

import Foundation


class dbContent {
    
    
     var myNewDictArray: [Dictionary<String, AnyObject>] = []
    // Do any additional setup after loading the view, typically from a nib.
    
    private let url = NSURL(string: "http://localhost/html/iosmysql.php")!
    
    
    //func getdbContent()-> Array<Dictionary<String, String>>{
    func getdbContent(completionHandler: (content: Array<Dictionary<String, AnyObject>>) -> ()) {
     
    let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
        
        
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