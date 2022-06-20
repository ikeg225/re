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
    
    func fetchRecordingsFromID(userID: String, _ completion: @escaping (_ data: Array<Recording>?) -> Void) {
        let document = Firestore.firestore().collection("Users").document(userID)
        
        document.getDocument { (document, error) in
            guard let document = document, document.exists else {
                print("document does not exist")
                completion(nil)
                return
            }
            
            var arrRecords: Array<Recording> = []
            for record in document.get("Recordings") as! [Any] {
                do {
                    let data = try JSONSerialization.data(withJSONObject: record, options: [])
                    let json = try JSONDecoder().decode(singleRecord.self, from: data)
                    arrRecords.append(Recording(Date: json.Date, File: json.File, Question: json.Question, Time: json.Time))
                } catch {
                    print("recording error")
                }
            }
            
            completion(arrRecords)
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

struct singleRecord: Decodable {
    var Date: String
    var File: String
    var Question: String
    var Time: String
}

class Recording: Codable, Hashable {
    static func == (lhs: Recording, rhs: Recording) -> Bool {
        return lhs.File == rhs.File && lhs.Date == rhs.Date
    }
    
    var Date: String
    var File: String
    var Question: String
    var Time: String

    init(Date: String, File: String, Question: String, Time: String) {
        self.Date = Date
        self.File = File
        self.Question = Question
        self.Time = Time
    }
    
    var hashValue: Int {
        get {
            return Date.hashValue << 15
        }
    }
}
