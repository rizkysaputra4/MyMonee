//
//  NetworkService.swift
//  MyMonee
//
//  Created by Rizky Saputra on 20/05/21.
//

import Foundation
import UIKit

let url: String = "https://60a59b18c0c1fd00175f4124.mockapi.io/api/v1/"

class NetworkService {
   
    func loadTransaction(completion: @escaping (_ transaction: [Transaction]) -> Void) {
        isLoading = true
        let component = URLComponents(string: "\(url)transaction")!

        var request = URLRequest(url: component.url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
            if let data = data {
                let decoder = JSONDecoder()
                
                guard let transactionFetched = try? decoder.decode([Transaction].self, from: data) as [Transaction] else {
                    print("error when fetchind transaction data")
                    return
                }
                
                completion(transactionFetched)
            }
        }
        
        task.resume()
    }
    
    func postTransaction(newTransaction: Transaction, completion: @escaping () -> Void) {
        let component = URLComponents(string: "\(url)transaction")!
    
        var request = URLRequest(url: component.url!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = newTransaction.encodeToJson()
        
        let task = URLSession.shared.dataTask(with: request) { (_, _, _) in
            completion()
        }
        
        task.resume()
    }
    
    func putTransaction(newTransaction: Transaction, completion: @escaping () -> Void) {
        
        guard let transsactionId = newTransaction.uuid else {
            return
        }
        
        let component = URLComponents(string: "\(url)transaction/\(transsactionId)")!
      
        var request = URLRequest(url: component.url!)
        request.httpMethod = "PUT"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = newTransaction.encodeToJson()
        
        let task = URLSession.shared.dataTask(with: request) { (_, _, _) in
            completion()
        }
        
        task.resume()
    }
    
    func deleteTransaction(newTransaction: Transaction?, completion: @escaping () -> Void) {
        
        guard let transsactionId = newTransaction?.uuid else {
            return
        }
        
        let component = URLComponents(string: "\(url)transaction/\(transsactionId)")!
      
        var request = URLRequest(url: component.url!)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { (_, _, _) in
            completion()
        }
        
        task.resume()
    }
}
