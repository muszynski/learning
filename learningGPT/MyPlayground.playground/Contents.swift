import CloudKit

class UserFetcher {
    func fetchUserName(completion: @escaping (String?) -> Void) {
        let container = CKContainer.default()
        container.fetchUserRecordID { recordID, error in
            if let error = error {
                print("Error fetching user record ID: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let recordID = recordID {
                let operation = CKFetchRecordsOperation(recordIDs: [recordID])
                operation.desiredKeys = ["firstName"]
                
                operation.fetchRecordsCompletionBlock = { records, error in
                    if let error = error {
                        print("Error fetching user info: \(error.localizedDescription)")
                        completion(nil)
                        return
                    }
                    
                    if let record = records?[recordID], let firstName = record["firstName"] as? String {
                        let components = firstName.split(separator: " ")
                        let name = components.first.map(String.init) ?? "Unknown user"
                        completion(name)
                    } else {
                        completion(nil)
                    }
                }
                
                container.privateCloudDatabase.add(operation)
            } else {
                completion(nil)
            }
        }
    }
}


let userFetcher = UserFetcher()
userFetcher.fetchUserName { name in
    if let name = name {
        print("Hello, \(name)!")
    } else {
        print("Unknown user")
    }
}
