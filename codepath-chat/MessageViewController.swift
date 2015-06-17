//
//  MessageViewController.swift
//  codepath-chat
//
//  Created by Patrick Dugan on 6/16/15.
//  Copyright (c) 2015 dailydoog. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var messages: [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func onTimer() {
        var query = PFQuery(className: "Message")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
            self.messages = results as! [PFObject]
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessageCell
        var message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        return cell
    }
    
    @IBAction func didPressSend(sender: UIButton) {
        var message = PFObject(className: "Message")
        message["text"] = textField.text
        message["user"] = PFUser.currentUser()
        message.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Saved the message!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
