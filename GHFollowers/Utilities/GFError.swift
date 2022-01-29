//
//  ErrorMessages.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 25.12.2021.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created invalid username. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server wasa invalid. Please try again"
    case unableToFavorite = "Ther was an error favoriting this user. Please try again"
    case alreadyInFavorites  = "You have already favorited this user. You must really like them"
}
