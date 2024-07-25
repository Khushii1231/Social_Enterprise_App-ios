//
//  DetailViewController.swift
//  SocioutApp
//
//  Created by swati mane on 07/09/22.
//

import UIKit

class DetailViewController: UIViewController {
    var post:jsonstruct?
    var arrdata1 = [PostComment]()
    var index : Int!
    
    @IBOutlet weak var tableView1: UITableView!
    
   
   override func viewDidLoad() {
        super.viewDidLoad()
        fetchComment()
        tableView1.reloadData()
       //self.tableView.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
       }
    
       
    fileprivate func fetchComment(){
         fetchComment{ (response) in
             switch response {
             case .failure(let error):
                 print("Failed to feth posts",error)
             case .success(let arrdata1):
                 self.arrdata1 = arrdata1
                 self.tableView1.reloadData()
             }
         }

     }
    
   
   func fetchComment( completion:@escaping(Result<[PostComment] ,Error>)->()){
           guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(post!.userId)/comments")else{return}

        URLSession.shared.dataTask(with: url) { data, response, error in

            if error == nil {
                do{
                let posts = try JSONDecoder().decode([PostComment].self, from: data!)
                        DispatchQueue.main.async{
                     completion(.success(posts))
                            print(posts)
                        }
                    }
                 catch{
                     print("Error fetching from api")
                     completion(.failure(error))
                 }
            }
       }.resume()

}
    
    func  sortingData(array:[PostComment]) -> [PostComment] {
        return array.sorted(by: {$0.id > $1.id})
       
    }

}

//MARK: -  TableView DataSource method
    
extension DetailViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arrdata1.count)
        return self.arrdata1.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //if indexPath.row>0{
            
        let cell:DetailTableViewCell = tableView1.dequeueReusableCell(withIdentifier: "cell1") as! DetailTableViewCell
           
        
        let arr = arrdata1[indexPath.row]
        cell.nameLable?.text = arr.name
           
        cell.emailLable?.text = arr.email

        cell.commentPost?.text = arr.body
        
        cell.textPostL?.text =  post!.title
            
        cell.bodyFeildL?.text = post!.body
            
        return cell
       
}
    }

