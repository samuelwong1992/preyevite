//
//  UserHelpers.swift
//  ivi
//
//  Created by Samuel Wong on 19/4/22.
//

import Foundation

class UserHelpers {
    static var user: User? {
        get {
            do {
                return try CoreDataManager.container.viewContext.fetch(User.fetchRequest()).first
            } catch {
                return nil
            }
        }
    }
    
    @discardableResult
    static func createUser(withPassword password: [StrokeDirection]) -> (user: User?, error: Error?) {
        let user = user ?? User(context: CoreDataManager.context)
        user.password = convertFromStrokeDirectionToString(password)
        
        do {
            try CoreDataManager.context.save()
            
            HistoryHelpers.createHistory(title: "Changed Password", note: "Changed password", severity: .Critical)
            
            return (user, nil)
        } catch {
            return (nil, error)
        }
    }
    
    static func verifyPassword(input: [StrokeDirection], password: [StrokeDirection]? = nil) -> Bool {
        if let password = password {
            return comparePasswords(input: input, password: password)
        } else {
            if let user = UserHelpers.user {
                let success = comparePasswords(input: input, password: user.getPassword())

                if success {
                    HistoryHelpers.createHistory(title: "Login", note: "App successfully logged in", severity: .Warning)
                } else if input.count%user.getPassword().count == 0 {
                    HistoryHelpers.createHistory(title: "Login", note: "App failed a log in", severity: .Critical)
                }

                return success
            } else {
                return false
            }
        }
    }
    
    private static func comparePasswords(input: [StrokeDirection], password: [StrokeDirection]) -> Bool {
        return String(convertFromStrokeDirectionToString(input).suffix(password.count)) == convertFromStrokeDirectionToString(password)
    }
    
    private static func convertFromStrokeDirectionToString(_ input: [StrokeDirection]) -> String {
        return input.map({ stroke in return "\(stroke.rawValue)" }).joined(separator: "")
    }
}

extension User {
    func getPassword() -> [StrokeDirection] {
        var toReturn: [StrokeDirection] = []
        for sd in self.password! {
            toReturn.append(StrokeDirection(rawValue: Int("\(sd)")!)!)
        }
        return toReturn
    }
}
