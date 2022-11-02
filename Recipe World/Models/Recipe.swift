//
//  Recipe.swift
//  Recipe World
//
//  Created by M W on 02/11/2022.
//

import Foundation
import UIKit

enum Cuisine {
    case british
    case spanish
    case indian
    case italian
    case chinese
    case healthy
    case quick
}


struct Recipe {
    var name: String
    var ingredients: String
    var timeToCook: String
    var rating: String
    var instructions: String
    var photo: UIImage
    var portionSize: Int
    var nutritionalInformation: String
    var cuisine: Cuisine
    var date: Date

}
