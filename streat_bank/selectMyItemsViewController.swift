//
//  selectMyItemsViewController.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 22/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//
// this class is used to share an item on FaceBook (a valid FaceBook account must be configured in the main settings)

import UIKit
import Social

class selectMyItemsViewController: UIViewController {

    @IBOutlet weak var itemPhoto: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var discriptionLable: UILabel!
    @IBAction func ShareOnFacebook(sender: AnyObject) {
        let name = jsonArray2[myItemsCounter]["name"]! as! String
        let item_photo = images5[myItemsCounter]
        let shareToFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareToFacebook.setInitialText("Hi, I'm offering my \(name) for lending on StreatBank app!")
        shareToFacebook.addImage(item_photo)
        self.presentViewController(shareToFacebook, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLable.text = jsonArray2[myItemsCounter]["name"]! as? String
        
        discriptionLable.text = jsonArray2[myItemsCounter]["description"]! as? String
        itemPhoto.image = images5[myItemsCounter]
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
