//
//  IntentController.swift
//  gexa-apiPackageDescription
//
//  Created by Dalton Claybrook on 10/7/17.
//

import Foundation
import Vapor

class IntentController {
    func handleRequest(_ request: Request) throws -> ResponseRepresentable {
        let intentAction = try request.toModel(IntentAction.self)
        switch intentAction.result.action {
        case "pay-bill-action":
            return try self.performPayBillAction(with: intentAction)
        default:
            return try self.performUnknownAction()
        }
    }
    
    // MARK: Private
    
    private func performPayBillAction(with action: IntentAction) throws -> ResponseRepresentable {
        let parameters = action.result.parameters
        guard var phoneNumber = parameters["phone-number"],
            var pin = parameters["account-pin"] else {
            throw Abort.invalidActionParameters
        }
        
        phoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        pin = pin.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard phoneNumber == "8066320911" && pin == "1234" else {
            return IntentResponse(text: "I'm sorry, I could not find an account that matched the provided information.")
        }
        
        let context = IntentContext(name: "payment", parameters: [
            "name": "Dalton"
        ])
        let data: [String: String] = [ "token": "abc123" ]
        
        let text = "Alright Dalton, your bill is $258.95. I'm ready to charge your Visa card ending in 9285. Would you like to continue?"
        return IntentResponse(text: text, data: data)
//        return IntentResponse(followUpEventName: "pay-confirmation-event", data: data, context: [context])
    }
    
    private func performUnknownAction() throws -> ResponseRepresentable {
        return IntentResponse(text: "Sorry, I don't understand what you're trying to do.")
    }
}
