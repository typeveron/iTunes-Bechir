//
//  YourFavVC.swift
//  iTunesB
//
//  Created by Mobile Apps on 2020-02-25.
//  Copyright © 2020 Bechir Mihoub. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class YourFavVC: UITableViewController, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AddDelegate {
    
    
    
    var itemType = ""
    var storeItems = [StoreItem]()
    var favItems = [StoreItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    func added(storeItem: StoreItem) {
        favItems.append(storeItem)
        print(favItems)
    }
    
  
    

    
   
    @IBAction func emailPressed(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Can not send mail")
            return
        }
        
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["example@example.com"])
        mailComposer.setSubject("Look at this")
        mailComposer.setMessageBody("Hello, this is an email from the app I made.", isHTML: false)
        present(mailComposer, animated: true, completion: nil)
        
    }
    
    

}
