//
//  File.swift
//  Meow Fest
//
//  Created by Brian Sakhuja on 12/12/18.
//  Copyright © 2018 Brian Sakhuja. All rights reserved.
//

import Foundation
import UIKit

class Cat
{
    let date: Date
    let imageURL: URL
    let title: String
    let description: String
    
    
    init(date: Date, imageURL: URL, title: String, description: String)
    {
        self.date = date
        self.imageURL = imageURL
        self.title = title
        self.description = description
        
    }
    
}
