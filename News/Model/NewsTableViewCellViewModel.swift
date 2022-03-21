//
//  NewsTableViewCellViewModel.swift
//  News
//
//  Created by Никита Коголенок on 21.03.22.
//

import Foundation

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    var imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}
