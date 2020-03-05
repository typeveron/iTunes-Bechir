//
//  IntroTableVC.swift
//  iTunesB
//
//  Created by Bechir Mihoub on 2020-02-24.
//  Copyright © 2020 Bechir Mihoub. All rights reserved.
//

import UIKit

class IntroTableVC: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var theSeg: UISegmentedControl!
    
    

    


    let storeItemController = StoreItemController()
    
    var items = [StoreItem]()
    
    let queryOptions = ["movie", "music", "software", "ebook"]
    
    var itemType = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeItemController.testFunction()
           
    }
    
    
    func fetchMatchingItems() {
        
            self.items = []
            self.tableView.reloadData()
            
            let searchTerm = searchBar.text ?? ""
            let mediaType = queryOptions[theSeg.selectedSegmentIndex]
            itemType = mediaType
            
            if !searchTerm.isEmpty {
                
                let query = [
                    "term": searchTerm,
                    "media": mediaType,
                    "lang": "en_us",
                    "limit": "10"
                ]
                
                storeItemController.fetchItems(matching: query) { (fetchedItems) in
                    if let fetchedItems = fetchedItems {
                        DispatchQueue.main.async {
                            self.items = fetchedItems
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    
        func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
            
            let item = items[indexPath.row]
            
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = item.artist
            cell.imageView?.image = UIImage(named: "gray-1")
            
            storeItemController.fetchItemArtwork(url: item.artworkURL) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                    }
                }
            }
        }
    
    
    
   
    @IBAction func filterPressed(_ sender: UISegmentedControl) {
        fetchMatchingItems()
    }
    
    
        // MARK: - Table view data source

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return items.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "celly", for: indexPath)
            configure(cell: cell, forItemAt: indexPath)
            return cell
        }
        
        // MARK: - Table view delegate
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    


 
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Check if EditEmoji segue is running pass the model object
      // related to selected cell
      
      if segue.identifier == "moreDetail" {
          
          // Which cell is selected ........................
          let indexPath = tableView.indexPathForSelectedRow!
          
          let item = items[indexPath.row]
          //................................................
      
          // Create a reference to next VC which is the first VC of UINavigationController
        let detailTableVC = segue.destination as! DetTableVC
          
          //................................................
          
          // Pass selected Object to target VC
          detailTableVC.item = item
          detailTableVC.itemType = itemType
      }
  }
  
  
  
  }

extension IntroTableVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
        print("search pressed")
        
    }
}




   


