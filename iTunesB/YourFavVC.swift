//
//  YourFavVC.swift
//  iTunesB
//
//  Created by Mobile Apps on 2020-02-25.
//  Copyright © 2020 Bechir Mihoub. All rights reserved.
//

import UIKit


class YourFavVC: UITableViewController {
    
    let storeItemController = StoreItemController()
    
    @IBOutlet weak var segmentedFav: UISegmentedControl!
    
    var selectedItems = [StoreItem]()
    
    var localfmo = favoriteMovie
    var localmu = favoriteMusic
    var localboo = favoriteBooks
    var localapps = favoriteSoftware
  

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedItems = favItemArray
        tableView.reloadData()
        navigationItem.rightBarButtonItem = editButtonItem

    }
    
    
    @IBAction func segmentedFinal(_ sender: UISegmentedControl) {
        switch segmentedFav.selectedSegmentIndex {
        case 0:
            selectedItems.removeAll()
            selectedItems = favoriteMovie
            tableView.reloadData()
        case 1:
            selectedItems.removeAll()
            selectedItems = favoriteMusic
            tableView.reloadData()
        case 2:
            selectedItems.removeAll()
            selectedItems = favoriteSoftware
            tableView.reloadData()
        case 3:
            selectedItems.removeAll()
            selectedItems = favoriteBooks
            tableView.reloadData()
        case 4:
            selectedItems.removeAll()
            selectedItems = favItemArray
            tableView.reloadData()
        default:
            selectedItems = favItemArray
        }
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        StoreItem.saveItems(selectedItems)
        print("Your items has been saved \(selectedItems) ")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedItems.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellf", for: indexPath)
        
        let theCell = selectedItems[indexPath.row]
        cell.showsReorderControl = true
        
        cell.textLabel?.text = theCell.name
        cell.detailTextLabel?.text = theCell.artist
        let url = theCell.artworkURL
        
        let task = URLSession.shared.dataTask(with: url){(data,response,error) in
            guard let imageData = data else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                cell.imageView?.image = image
            }
        }
        task.resume()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedItem = selectedItems.remove(at: fromIndexPath.row)
        selectedItems.insert(movedItem, at: to.row)
        tableView.reloadData()
        
    }
    
   
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {

        if editingStyle == .delete{
            switch segmentedFav.selectedSegmentIndex {
            case 0:
                selectedItems.remove(at: indexPath.row)
                favoriteMovie.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)

            case 1:
                selectedItems.remove(at: indexPath.row)
                favoriteMusic.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)


            case 2:
                selectedItems.remove(at: indexPath.row)
                favoriteSoftware.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)


            case 3:
                selectedItems.remove(at: indexPath.row)
                favoriteBooks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)


            case 4:
                selectedItems.remove(at: indexPath.row)
                favItemArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)


            default:
                selectedItems = favItemArray
            }
        }
    }
}
