//
//  Abort+Additions.swift
//  gexa-apiPackageDescription
//
//  Created by Dalton Claybrook on 10/7/17.
//

import Foundation
import Vapor

extension Abort {
    static var invalidJSON: Abort {
        return Abort(.badRequest, reason: "Invalid JSON")
    }
    
    static var invalidActionParameters: Abort {
        return Abort(.badRequest, reason: "Invalid action parameters")
    }
}
