//
//  IntentAction.swift
//  gexa-apiPackageDescription
//
//  Created by Dalton Claybrook on 10/7/17.
//

import Foundation
import Vapor

struct IntentAction {
    let id: String
    let sessionId: String
    let status: IntentStatus
    let result: IntentResult
}

struct IntentStatus {
    let isSuccess: Bool
    let code: Int
}

struct IntentResult {
    let action: String
    let parameters: [String: String]
    let score: Double
    let metadata: [String: String]
}

// MARK: JSON

extension IntentAction: JSONInitializable {
    init(json: JSON) throws {
        self.id = try json.get("id")
        self.sessionId = try json.get("sessionId")
        self.status = try IntentStatus(json: json.get("status"))
        self.result = try IntentResult(json: json.get("result"))
    }
}

extension IntentStatus: JSONInitializable {
    init(json: JSON) throws {
        let errorType: String = try json.get("errorType")
        self.isSuccess = errorType == "success"
        self.code = try json.get("code")
    }
}

extension IntentResult: JSONInitializable {
    init(json: JSON) throws {
        self.action = try json.get("action")
        self.parameters = try json.get("parameters")
        self.score = try json.get("score")
        self.metadata = try json.get("metadata")
    }
}
