//
//  RegisterController.swift
//  SocioutApp
//
//  Created by swati mane on 06/09/22.
//

import UIKit
import Firebase

class RegisterController: UIViewController {
    var iconClick = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var eyeAction: UIButton!
    
        
    @IBAction func eyeAction(_ sender: Any) {
    
    if (iconClick==true){
        
           eyeAction.setImage(UIImage(named: "eye"), for: .normal)
            passwordTextFeild.isSecureTextEntry=false
        }else{
            eyeAction.setImage(UIImage(named: "eye.slash"), for: .normal)
                passwordTextFeild.isSecureTextEntry=true
        }
        iconClick = !iconClick
    }
    
    
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        var textFeild = UITextField()
        
        if let email = emailTextFeild.text , let password = passwordTextFeild.text {
            
            Auth.auth().createUser(withEmail: email, password: password){
                authResult , error in
              
                if let e = error{
                    
                    let alert = UIAlertController(title: "Inavalid Email/Password", message: "", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .default)
                    
                    alert.addTextField { (alertTextField) in
                        alertTextField.text = e.localizedDescription
                        textFeild = alertTextField
                    }
                    
                    print(e.localizedDescription)
                    
                    
                    alert.addAction(action)
                    
                    self.present(alert , animated: true  , completion: nil)
                    
                }else{
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    let alert = UIAlertController(title: "Register Successfully", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(action)
                    self.present(alert , animated: true  , completion: nil)
                    
                }
                
            }
            
        }
        
                
    }
}
        
        
        
        
        
    
    

