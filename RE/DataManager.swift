//
//  DataManager.swift
//  RE
//
//  Created by Ethan Ikegami on 6/14/22.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
        
    init() {}
    
    func fetchCodeFromID(userID: String, _ completion: @escaping (_ data: Int?) -> Void) {
        let document = Firestore.firestore().collection("Users").document(userID)
        
        document.getDocument { (document, error) in
            guard let document = document, document.exists else {
                print("document does not exist")
                completion(nil)
                return
            }
            completion(document.get("PartnerCode") as? Int ?? 0)
        }
    }
        
    func addUser(userID: String, partnerCode: Int, name: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(userID)
        ref.setData(["Name": name, "PartnerCode": partnerCode, "Recordings": []]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
