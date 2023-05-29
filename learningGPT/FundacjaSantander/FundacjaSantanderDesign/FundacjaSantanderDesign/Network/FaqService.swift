//
//  FaqService.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 29/05/2023.
//

import Foundation

class FaqService {
    
    private let wordpressApi = WordPressAPI()
    
    // Nowa funkcja, która pobiera i zapisuje wszystkie FAQ
    func fetchAndSaveAllFaqs(completion: @escaping (Error?) -> Void) {
        wordpressApi.fetchFaqs { result in
            switch result {
            case .success(let (faqs, _)):
                //MARK: tu moze byc blad
                saveFaqToCoreData(faq: faqs) { error in
                    if let error = error {
                        print("Failed to save FAQs:", error)
                        completion(error)
                    } else {
                        print("FAQs saved successfully.")
                        completion(nil)
                    }
                }
            case .failure(let error):
                print("Failed to fetch FAQs:", error)
                completion(error)
            }
        }
    }
}
