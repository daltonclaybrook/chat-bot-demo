//
//  IntentResponse.swift
//  App
//
//  Created by Dalton Claybrook on 10/7/17.
//

import Foundation
import Vapor

struct IntentResponse {
    let speech: String
    let displayText: String
    let data: [String: String]
    let contextOut: [IntentContext]
    let followUpEvent: FollowUpEvent?
    
    init(text: String, data: [String: String] = [:], context: [IntentContext] = []) {
        self.speech = text
        self.displayText = text
        self.data = data
        self.contextOut = context
        self.followUpEvent = nil
    }
    
    init(followUpEventName: String, data: [String: String] = [:], context: [IntentContext] = []) {
        self.speech = ""
        self.displayText = ""
        self.data = data
        self.contextOut = context
        self.followUpEvent = FollowUpEvent(name: followUpEventName)
    }
}

struct IntentContext {
    let name: String
    let parameters: [String: String]
    
    init(name: String, parameters: [String: String]) {
        self.name = name
        self.parameters = parameters
    }
    
    init(sharedParameters: [String: String]) {
        self.init(name: "shared", parameters: sharedParameters)
    }
}

struct FollowUpEvent {
    let name: String
}

// MARK: JSON

extension IntentResponse: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("speech", self.speech)
        try json.set("displayText", self.displayText)
        try json.set("data", self.data)
        try json.set("contextOut", self.contextOut.map { try $0.makeJSON() })
        if let event = self.followUpEvent {
            try json.set("followUpEvent", event.makeJSON())
        }
        return json
    }
}

extension IntentContext: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("name", self.name)
        try json.set("parameters", self.parameters)
        return json
    }
}

extension FollowUpEvent: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("name", self.name)
        return json
    }
}

// MARK: Response

extension IntentResponse: ResponseRepresentable {
    func makeResponse() throws -> Response {
        return try Response(status: .ok, json: self.makeJSON())
    }
}
