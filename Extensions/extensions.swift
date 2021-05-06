//
//  extensions.swift
//  TodoApplication
//
//  Created by Ovais Naveed on 4/17/21.
//

import Foundation
import UIKit

extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        return dateFormatter.string(from: Date())
        
    }
}


extension Array where Element: Equatable {

    func indexes(of item: Element) -> [Int]  {
        return enumerated().compactMap { $0.element == item ? $0.offset : nil }
    }
}
