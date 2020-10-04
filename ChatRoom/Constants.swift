//
//  Constants.swift
//  ChatRoom
//
//  Created by Harsh Patel on 01/10/20.
//  Copyright © 2020 Harsh Patel. All rights reserved.
//

import Foundation

struct K {
    static let appName = "ChatRoom"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
