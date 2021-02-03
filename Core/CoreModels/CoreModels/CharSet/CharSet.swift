//
//  CharSet.swift
//  CoreModels
//
//  Created by Максим Шаптала on 03.02.2021.
//

import Foundation

public struct CharSet {
    public let char: Character
    public let count: Int
    
    public init(char: Character, count: Int) {
        self.char = char
        self.count = count
    }
}
