//
//  ToDoListItem.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 10.03.23.
//

import Foundation

struct ToDoListItem : Codable, Equatable {
    let itemId : String
    let mainTitle : String
    let subTitle : String
    let itemStatus : Bool
}
