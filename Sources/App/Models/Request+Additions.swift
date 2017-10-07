//
//  Request+Additions.swift
//  gexa-apiPackageDescription
//
//  Created by Dalton Claybrook on 10/7/17.
//

import Foundation
import Vapor

extension Request {
    func toModel<T: JSONInitializable>(_ model: T.Type) throws -> T {
        guard let json = json else { throw Abort.invalidJSON }
        return try T(json: json)
    }
}

