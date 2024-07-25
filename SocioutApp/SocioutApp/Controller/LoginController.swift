//
//  LoginController.swift
//  SocioutApp
//
//  Created by swati mane on 06/09/22.
//

import UIKit
import Firebase

class LoginController: UIViewController {
     
    var iconClick = true
    override func viewDidLoad() {
        super.viewDidLoad()
}
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    @IBOutlet weak var eyeActionLogin: UIButton!
    
    @IBAction func eyeActionLogin(_ sender: Any) {
        
        if (iconClick==true){
            
            eyeActionLogin.setImage(UIImage(systemName: "eye"), for: .normal)
                passwordTextFeild.isSecureTextEntry=false
            }else{
                eyeActionLogin.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                    passwordTextFeild.isSecureTextEntry=true
            }
            iconClick = !iconClick
        

        
    }
  
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextFeild.text , let password = passwordTextFeild.text{
            
            var textFeild = UITextField()
            Auth.auth().signIn(withEmail : email , password:password){
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
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
    }
    
}
    
}
