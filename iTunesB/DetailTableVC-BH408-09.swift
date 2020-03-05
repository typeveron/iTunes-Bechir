//
//  DetailTableVC.swift
//  iTunesB
//
//  Created by Bechir Mihoub on 2020-02-24.
//  Copyright © 2020 Bechir Mihoub. All rights reserved.
//

import UIKit

protocol AddDelegate {
    func added(storeItem: StoreItem)
}

class DetailTableVC: UITableViewController {
    
    var delegate: AddDelegate?
    
    let storeItemController = StoreItemController()
    
    @IBOutlet weak var theImage: UIImageView!
    
    @IBOutlet weak var theArtist: UITextField!
    
    @IBOutlet weak var shortDes: UILabel!
    
    @IBOutlet weak var theKind: UITextField!
    
    @IBOutlet weak var theFav: UIBarButtonItem!
    
    var item: StoreItem?
    
    var itemType = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        theArtist.text = item?.artist
        shortDes.text = item?.description
        theKind.text = item?.kind
        theImage.image = UIImage(named: "grey-1")
            
        storeItemController.fetchItemArtwork(url: item!.artworkURL) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.theImage.image = image
                    }
                }
            }
        }
    
    func setupDelegate(){
        if let navController = tabBarController?.viewControllers?.last as? UINavigationController{
            if let yourFavVC = navController.viewControllers.first as? YourFavVC {
                delegate = yourFavVC 
            }
        }
        
    }
    
    
    @IBAction func addToFavs(_ sender: UIBarButtonItem) {
        delegate?.added(storeItem: item!)
        print("added to favourites")
    }
    
    
}
       
    

    
