//
//  ViewController.swift
//  SocioutApp
//
//  Created by swati mane on 05/09/22.
//

import UIKit
import Lottie


class ViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
   
    @IBOutlet weak var titleLable: UILabel!
    private var animationView: AnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = .init(name: "loginAnimation")
        animationView!.frame = view.bounds
        
        // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        animationView!.animationSpeed = 0.5
        
        view.addSubview(animationView!)
        
        // 6. Play animation
        animationView!.play()
       view.sendSubviewToBack(animationView!)
        
        titleLable.text = ""
        var charIndex = 0.0
        let titleText = K.appName
        
        for letter in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.1*charIndex, repeats: false) { (timer) in
                self.titleLable.text?.append(letter)
            }
            charIndex = charIndex+1
        }
    }

}
    
    

