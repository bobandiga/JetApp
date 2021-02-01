//
//  RequestType.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation

public enum RequestType {
    
    case simple
    case upload(data: Data?)
    case download
    
}
