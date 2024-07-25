//
//  HomeViewController.swift
//  SocioutApp
//
//  Created by swati mane on 06/09/22.
//

import UIKit
import Firebase
class HomeViewController: UIViewController
{
   
   var arrdata = [jsonstruct]()
   var createView = CreateViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        view.addSubview(floatinButton)
        floatinButton.addTarget(self, action: #selector(didtapButton), for: .touchUpInside)
       navigationItem.hidesBackButton = true
}
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "are you sure to logout", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .cancel){(action) in
            do {
                try Auth.auth().signOut()
                self.navigationController?.popToRootViewController(animated: true)
             }catch let signOutError as NSError {
                print("Erropr signing out" , signOutError)
            }
        
        }
        
        let action2 = UIAlertAction(title: "Cancel", style: .default )
        alert.addAction(action)
        alert.addAction(action2)
        present(alert , animated: true  , completion: nil)
        
    }
    
@IBOutlet weak var tableView: UITableView!
    
   fileprivate func fetchPosts(){
        Service.shared.fetchPosts { (res) in
            switch res {
            case .failure(_):
                print("Failed to feth posts")
            case .success(let arrdata):
                self.arrdata = arrdata
                self.tableView.reloadData()
            }
        }
        
   }
    private let floatinButton : UIButton = {
        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 60, height: 60))
        button.backgroundColor = .blue
        let image = UIImage(systemName:"plus" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 32 , weight:.medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3

        //corner radius
        button.layer.cornerRadius = 30
        return button
}()

    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       floatinButton.frame = CGRect(x: view.frame.size.width-70,
                                    y: view.frame.size.height-100, width: 60, height: 60)
}

   @objc private func didtapButton(){
       let create =  self.storyboard?.instantiateViewController(withIdentifier: "create") as! CreateViewController
       self.navigationController?.pushViewController(create, animated: true)
}
}

//MARK: -  TableView DataSource method
    
extension HomeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arrdata.count)
        return self.arrdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let post = arrdata[indexPath.row]
        cell.titlePostLable?.text = post.title
        cell.bodyPostLable?.text = post.body
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            tableView.beginUpdates()
            let post = self.arrdata[indexPath.row]
            Service.shared.deletePost(id: post.id) { error in
                if let error = error {
                    print("failed to delete:",error)
                    return
                }
                print("succefully deleted post from server")
                 self.arrdata.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
           
        }
    }
    
}
    
//MARK: - TableView Delegate Method

extension HomeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailPost", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController{
            destination.post = arrdata[tableView.indexPathForSelectedRow!.row]
            //print(arrdata)
           
    }
}
    
}
   


    

