//
//  File.swift
//  
//
//  Created by Besar Ismaili on 29/10/2019.
//

import Foundation

public struct Page {
    let image: String
    let header: String
    let description: String
    
    public init(image: String, header: String, description: String) {
        self.image = image
        self.header = header
        self.description = description
    }
}



