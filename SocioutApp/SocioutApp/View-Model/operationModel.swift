//
//  operationModel.swift
//  SocioutApp
//
//  Created by swati mane on 11/09/22.
//

import Foundation

class Service:NSObject {
    static let shared = Service()
    
    
    //MARK: - GET-POST
    
    func fetchPosts( completion:@escaping(Result<[jsonstruct] ,Error>)->()){
        // create URL
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")else{return}
        //Create urlSession & task session
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                         print("fails to fetch post:", error)
                    return
                 }
                 guard let data = data else {
                     return
                 }
      
                 do{
                     let posts = try JSONDecoder().decode([jsonstruct].self, from: data)
                     completion(.success(posts))
                 }catch{
                     completion(.failure(error))
                 }
            }
          //start the task
        }.resume()
    }
    
    
    //MARK: - DELETE-POST
    
    func deletePost(id:Int , completion:@escaping(Error?)->()){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(error)
                    return
                }
                completion(nil)
            }
            
        } .resume()
        
        
    }
    
}

