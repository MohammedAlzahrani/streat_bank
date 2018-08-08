//
//  myBorrowedItemsTableViewController.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 16/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit
 var myBorrowedItemsArray: [Dictionary<String, AnyObject>] = []
    var images4 = [UIImage]()
class myBorrowedItemsTableViewController: UITableViewController {
    
    @IBOutlet var myBorrowedItemsTableView: UITableView!
    
    let request = httpPostRequest()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(myBorrowedItemsArray)
//        if myBorrowedItemsArray.count==0{
//            getDBcontent()
//            
//        }


    }
    
    override func viewDidAppear(animated: Bool) {
        
        if(loggedin == true){
            if myBorrowedItemsArray.count==0{
                
                getDBcontent()
            }
            
        }
        else{
            self.myBorrowedItemsTableView.reloadData()
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
            return myBorrowedItemsArray.count}
        else{
            return 0
        }
       
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        if(loggedin == true){
        cell.name.text = myBorrowedItemsArray[indexPath.row]["name"]! as? String
        cell.photo.image = images4[indexPath.row]
        cell.descr.text = myBorrowedItemsArray[indexPath.row]["firstName"] as? String
        }
        // Configure the cell...

        return cell
    }
    
    func getImg(imgLink: String)->(UIImage){
        
        let url = NSURL(string: "http://localhost/html/imgs/\(imgLink)")!
        
        let data = NSData(contentsOfURL: url)
        
        let image = UIImage(data: data!)
        
        
        return image!
    }
    
    func getDBcontent(){
        let url = NSURL(string: "http://localhost/html/myborrowedItems.php")!
        let postString = "myOwnerID=" + String(userID)
        request.getResponse(url, postingString: postString) {
            content in
            dispatch_async(dispatch_get_main_queue()) {
                // go to something on the main thread
                // download json data form the server
                myBorrowedItemsArray = content
                
                // iterate through the array and get image
                for item in myBorrowedItemsArray{
                    let link = item["image"]
                    // append image to images array
                    images4.append(self.getImg(link! as! String))
                    
                }
                self.tableView.reloadData()
                
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
