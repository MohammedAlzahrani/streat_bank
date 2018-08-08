//
//  MyRequestsTableViewController.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 18/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit
var myRequestArray: [Dictionary<String, AnyObject>] = []
  var images2 = [UIImage]()
class MyRequestsTableViewController: UITableViewController {
    @IBOutlet var MyRequestsTableView: UITableView!
    
    let request = httpPostRequest()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        if myRequestArray.count==0{
//            getDBcontent()
//            
//        }
    }
    override func viewDidAppear(animated: Bool) {
        
        if(loggedin == true){
            if myRequestArray.count==0{
                
                getDBcontent()
            }
            
        }
        else{
            self.MyRequestsTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == UIEventSubtype.MotionShake {
            
            getDBcontent()
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(loggedin == true){
            return myRequestArray.count}
        else{
            return 0
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        if(loggedin == true){
        cell.name.text = myRequestArray[indexPath.row]["name"]! as? String
        cell.photo.image = images2[indexPath.row]
        cell.descr.text = myRequestArray[indexPath.row]["firstName"] as? String
        
        if(myRequestArray[indexPath.row]["requestState"] as? String == "0"){
            cell.state.text = "rejected"
        }
        else if(myRequestArray[indexPath.row]["requestState"] as? String == "1"){
            cell.state.text = "accepted"
        }
        else{
            cell.state.text = "pending"
        }
        }

        return cell
    }

    
    func getImg(imgLink: String)->(UIImage){
        
        let url = NSURL(string: "http://localhost/html/imgs/\(imgLink)")!
        
        let data = NSData(contentsOfURL: url)
        
        let image = UIImage(data: data!)
        
        
        return image!
    }
    
    func getDBcontent(){
        let url = NSURL(string: "http://localhost/html/myRequests.php")!
        let postString = "userID=" + String(userID)
        
        request.getResponse(url, postingString: postString) {
            content in
            dispatch_async(dispatch_get_main_queue()) {
                // go to something on the main thread
                // download json data form the server
                myRequestArray = content
                
                // iterate through the array and get image
                for item in myRequestArray{
                    let link = item["image"]
                    // append image to images array
                    images2.append(self.getImg(link! as! String))
                    
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
