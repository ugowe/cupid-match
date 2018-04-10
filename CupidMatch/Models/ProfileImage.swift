//
//  ProfileImage.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import Foundation
import UIKit

struct ProfileImage {
    
    let largeImageURL: URL
    let smallImageURL: URL
    let mediumImageURL: URL
    let originalImageURL: URL

    init(largeImageURL: URL, smallImageURL: URL, mediumImageURL: URL, originalImageURL: URL) {
        self.largeImageURL = largeImageURL
        self.smallImageURL = smallImageURL
        self.mediumImageURL = mediumImageURL
        self.originalImageURL = originalImageURL
    }
    
    func downloadImage(url: URL,_ completionHandler: @escaping (_ image: UIImage?) -> () ){
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let imageData = data else { return }
                
                if let image = UIImage(data: imageData){
                    completionHandler(image)
                }
            }
        }.resume()
    }
}
