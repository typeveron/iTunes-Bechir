//
//  DetTableVC.swift
//  iTunesB
//
//  Created by Mobile Apps on 2020-02-27.
//  Copyright © 2020 Bechir Mihoub. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class DetTableVC: UITableViewController, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let storeItemController = StoreItemController()
    
    @IBOutlet weak var tImage: UIImageView!
    
    
    @IBOutlet weak var tArtist: UITextField!
    
    
    @IBOutlet weak var tDes: UILabel!
    
    
    @IBOutlet weak var tKind: UITextField!
    
    var item: StoreItem?
    
    var itemType = ""
    
    var favItem: StoreItem?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let item = item {
            tArtist.text = item.artist
            tDes.text = item.description
            tKind.text = item.kind
            tImage.image = UIImage(named: "grey-1")
            
            storeItemController.fetchItemArtwork(url: item.artworkURL) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.tImage.image = image
                    }
                }
            }
        }
    }
    
    @IBAction func addFavPressed(_ sender: UIBarButtonItem) {
        favItem = item
        let beforen = favItemSet.count
        favItemSet.insert(favItem!)
        let aftern = favItemSet.count
        if beforen != aftern {
            favItemArray.append(favItem!)
        }
        
        switch itemType {
        case "movie": //"movie", "music", "software", "ebook"
            favoriteMovie.append(favItem!)
            favoriteMovie.removeDuplicates()
            favDict.updateValue(favoriteMovie, forKey: "movie")
        case "music":
            favoriteMusic.append(favItem!)
            favoriteMusic.removeDuplicates()
            favDict.updateValue(favoriteMusic, forKey: "music")
        case "software":
            favoriteSoftware.append(favItem!)
            favoriteSoftware.removeDuplicates()
            favDict.updateValue(favoriteSoftware, forKey: "software")
        case "ebook":
            favoriteBooks.append(favItem!)
            favoriteBooks.removeDuplicates()
            favDict.updateValue(favoriteBooks, forKey: "ebook")
        default:
            return
        }
        print("added to favourites \(favItem)")
    }
    
    
    @IBAction func emailPressed(_ sender: UIButton) {
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
    
    
    
    @IBAction func sharePressed(_ sender: UIButton) {
        
        guard let image = tImage.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController,animated: true, completion: nil)
    }
    
    
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
    
    

    





