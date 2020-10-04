//
//  ChatViewController.swift
//  ChatRoom
//
//  Created by Harsh Patel on 29/09/20.
//  Copyright © 2020 Harsh Patel. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
       
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.messages = []
                   
            if let e = error {
                print("Issue retrieving data from Firestore \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data:
                [K.FStore.senderField : messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970 ]) {
                    (error) in
                if let e = error {
                    print("Issue Saving Data \(e)")
                } else {
                    print("Successfully Save Data")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //Message from current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            cell.messageBubble.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            //Message from another sender
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.messageBubble.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            cell.label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        
        
        return cell
    }
    
}
