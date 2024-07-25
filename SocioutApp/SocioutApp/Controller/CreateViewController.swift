//
//  createViewController.swift
//  SocioutApp
//
//  Created by swati mane on 08/09/22.
//

import UIKit

protocol createViewDelegate{
    
    func createView(text : String, body : String)
}

class CreateViewController: UIViewController  {
    
    
    var delegate: createViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
    @IBOutlet weak var textFeild: UITextField!
    
    @IBOutlet weak var bodyFeild: UITextField!
    
    @IBAction func savePostButton(_ sender: UIButton) {
        
        let home:HomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        dismiss(animated: true , completion: nil)
        
        delegate?.createView(text: textFeild.text!, body: bodyFeild.text!)
        
        self.navigationController?.pushViewController(home, animated: true)

        postMethod()
}
    
  }

extension CreateViewController {
    
    func postMethod(){
        
        guard let title = self.textFeild.text else{return}
        guard let body = self.bodyFeild.text else{return}
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts/"){
            var request = URLRequest(url: url)
            
            //The HTTP request method.
            request.httpMethod = "POST"
        
            let parameters: [String : Any] = [
                "title": title,
                "body": body
            ]
            
    //httpBody-The data sent as the message body of a request, such as for an HTTP POST request.
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if error == nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }
    
                if let response = response as? HTTPURLResponse{
                    guard (200 ... 299) ~= response.statusCode else {
                        print("Status code :- \(response.statusCode)")
                        print(response)
                        return
                    }
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch let error{
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}

extension Dictionary {
func percentEscaped() -> String {
    return map { (key, value) in
        let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
        let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
        return escapedKey + "=" + escapedValue
    }
    .joined(separator: "&")
}
}

extension CharacterSet {
static let urlQueryValueAllowed: CharacterSet = {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="

    var allowed = CharacterSet.urlQueryAllowed
    allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    return allowed
}()
}





   
