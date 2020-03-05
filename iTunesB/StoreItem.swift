//
//  StoreItem.swift
//  iTunesB
//
//  Created by Bechir Mihoub on 2020-02-24.
//  Copyright © 2020 Bechir Mihoub. All rights reserved.
//


import Foundation


struct StoreItem: Codable, Hashable {
    var name: String
    var artist: String
    var kind: String
    var artworkURL: URL
    var description: String?

    
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case kind = "kind"
        case artworkURL = "artworkUrl100"
        case description = "description"
    }
    
    enum AdditionalKeys: String, CodingKey {
        case longDescription
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        artist = try values.decode(String.self, forKey: CodingKeys.artist)
        kind =  try values.decode(String.self, forKey: CodingKeys.kind)
        artworkURL = try values.decode(URL.self, forKey: CodingKeys.artworkURL)
        
        if let description = try? values.decode(String.self, forKey: CodingKeys.description){
            self.description = description
        }else{
            let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
            description = (try? additionalValues.decode(String.self, forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
    static func loadItems() -> [StoreItem]? {
        //return nil
        guard let codedItems = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Array<StoreItem>.self, from: codedItems)
    }
    
    static func saveItems(_ itunes: [StoreItem]) {
        let propertyListEncoder = PropertyListEncoder()
        
        let codedItems = try? propertyListEncoder.encode(itunes)
        
        try? codedItems?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("itunes").appendingPathExtension("plist")
    
}
struct StoreItems: Codable {
    let results: [StoreItem]
}

