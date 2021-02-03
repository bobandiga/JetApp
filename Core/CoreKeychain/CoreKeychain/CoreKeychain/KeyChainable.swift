//
//  KayChainable.swift
//  CoreKeychain
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import Security

public protocol KeyChainable {
    associatedtype Object
    func setObject(object: Object)
    func getObject() -> Object?
    func deleteObject()
}
