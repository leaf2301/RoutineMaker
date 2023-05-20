//
//  Optional.swift
//  RoutineMaker
//
//  Created by Tran Hieu on 20/05/2023.
//

import Foundation

extension Optional where Wrapped == String {
    var defaultString: String {
        guard let self = self else { return "" }
        return self
    }
}
