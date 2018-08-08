//
//  ViewController.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 11/08/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

// this class is used to display all of the items in the database

import UIKit

var activeItem = -1
var userID: Int = -1
var loggedin2 = NSUserDefaults.standardUserDefaults().objectForKey("lg")! as! Bool
var images = [UIImage]()
var jsonArray: [Dictionary<String, AnyObject>] = []

let db = dbContent()



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //let link = NSURL(string: "http://localhost/html/iosmysql.php")!
  
    @IBOutlet weak var tableVeiw: UITableView!
    
    @IBOutlet weak var add: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     //   if jsonArray.count==0{
       //     getDBcontent()
        
        
        //}
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
       // if(loggedin == true){
            if(loggedin2 == true){
            if jsonArray.count==0{
                
                getDBcontent()
                //storeData(userID)
            }
            
        }
        else{
            self.tableVeiw.reloadData()
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        //return cellContent.count
        //if(loggedin == true){
        if(loggedin2 == true){
            return jsonArray.count}
        else{
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       

        
        let cell = self.tableVeiw.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        if(loggedin2 == true){
        cell.photo.image = images[indexPath.row]
        
        cell.name.text = jsonArray[indexPath.row]["name"]! as? String
        
        cell.descr.text = jsonArray[indexPath.row]["description"]! as? String
        }
        return cell
    }
    
     func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        activeItem = indexPath.row
        
        return indexPath
        
    }
    
    func storeData(){
    //NSUserDefaults.standardUserDefaults().setObject(userid, forKey: "userid")
        let usrid = NSUserDefaults.standardUserDefaults().objectForKey("userid")!
        
        print(usrid)
    
    }
    

    
    func getImg(imgLink: String)->(UIImage){
        
        let url = NSURL(string: "http://localhost/html/imgs/\(imgLink)")!
        
        let data = NSData(contentsOfURL: url)
        
        let image = UIImage(data: data!)
        
        
        return image!
    }
    
    func getDBcontent(){
        
        db.getdbContent() {
            content in
            dispatch_async(dispatch_get_main_queue()) {
                // go to something on the main thread
                // download json data form the server
                jsonArray = content
               // NSUserDefaults.standardUserDefaults().setObject(jsonArray, forKey: "js")
                // iterate through the array and get image
                for item in jsonArray{
                    let link = item["image"] as! String
                    // append image to images array
                    images.append(self.getImg(link))
                   // NSUserDefaults.standardUserDefaults().setObject(images, forKey: "im")
                    
                }
                self.tableVeiw.reloadData()
                
            }
            
        }

    }

}

