//
//  myItemsTableViewController.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 15/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit
var jsonArray2: [Dictionary<String, AnyObject>] = []
    var images5 = [UIImage]()
var myItemsCounter = -1
class myItemsTableViewController: UITableViewController {
    
        var result: NSString = ""
    
    @IBOutlet var myItemsTableView: UITableView!
    
    //var cellContent = ["Drill","Lawn Mower","trolley"]
    //var descri = ["Hi, I bought this last month and I only use it once. I am happy to lend it to anyone for free","Hi all, I have a lawn mower available for you. Any one can borrow it within Hokowhito area",""]
    //var images2 = [UIImage(named: "drill"),UIImage(named: "mower"), UIImage(named: "trolley")]
    
    
   // var images5 = [UIImage]()
    let request = httpPostRequest()
    let request2 = postRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

  
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if(loggedin == true){
            if jsonArray2.count==0{
               
                getDBcontent()
            }
            
        }
        else{
            self.myItemsTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(loggedin == true){
            return jsonArray2.count}
        else{
            return 0
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        if(loggedin == true){
        //cell.name.text = self.cellContent[indexPath.row]
        cell.name.text = jsonArray2[indexPath.row]["name"]! as? String
        //cell.descr.text = descri[indexPath.row]
        cell.photo.image = images5[indexPath.row]
        if (jsonArray2[indexPath.row]["itemState"]! as! String == "1"){
            cell.descr.text = "Available for lending"}
        else if (jsonArray2[indexPath.row]["itemState"]! as! String == "0"){
            cell.descr.text = "Borrowed"
        }
        }
        // Configure the cell...

        return cell
    }
    
        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
    
                deleteItem(indexPath.row)
    
            }
        }
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        myItemsCounter = indexPath.row
        
        return indexPath
        
    }

    func getImg(imgLink: String)->(UIImage){
        
        let url = NSURL(string: "http://localhost/html/imgs/\(imgLink)")!
        
        let data = NSData(contentsOfURL: url)
        
        let image = UIImage(data: data!)
        
        
        return image!
    }
    
    func getDBcontent(){
       let url = NSURL(string: "http://localhost/html/sss.php")!
       let postString = "myOwnerID=" + String(userID)
        request.getResponse(url, postingString: postString) {
            content in
            dispatch_async(dispatch_get_main_queue()) {
                // go to something on the main thread
                // download json data form the server
                jsonArray2 = content
                
                // iterate through the array and get image
                for item in jsonArray2{
                    let link = item["image"]
                    // append image to images array
                    images5.append(self.getImg(link! as! String))
                    
                }
                self.tableView.reloadData()
                
            }
            
        }
        
    }
    
    func deleteItem(i: Int){
        
        let url = NSURL(string: "http://localhost/html/deleteItem.php")!
        let itemID = jsonArray2[i]["itemID"]!
        let postString = "itemID=" + String(itemID)
        
        
        
        //let postString = "userID=2&itemID=555&ownerID=1"
        
        request2.getResponse(url, postingString: postString) {
            content in
            dispatch_async(dispatch_get_main_queue()) {
                
                
                self.result = content
                var resultTitle = ""
                var resultMessage = ""
                
                if(self.result == "success"){
                    resultTitle = "successful delete"
                    resultMessage = "your selected item was successfully deleted"
                }
                    
                else{
                    resultTitle = "error"
                    resultMessage = "your request was not sent. Please try again!"
                }
                
                let alert = UIAlertController(title: resultTitle, message: resultMessage, preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "Done", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                self.getDBcontent()
                
                
            }
            
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
