//
//  IntroController.swift
//  Lagree
//
//  Created by alk msljc on 9/13/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class IntroController: UIViewController {
    
    
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    
    @IBAction func logInButton(_ sender: UIButton) {
        AbstractViewController.goToLoginController(animationType: .ANIMATE_LEFT)
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        AbstractViewController.goToSignupController(animationType: .ANIMATE_LEFT)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.signUp.backgroundColor = UIColor.lagreeRed()
        //self.signUp.setRounded()
        //self.logIn.setRoundedBorder()
        setBackground()
        signUpButtonOutlet.setLagreeRedColor()
        // Do any additional setup after loading the view.
    }
    
    
    //Set background image
    func setBackground() {
        self.view.backgroundColor = .black
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "introBackground")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
    //Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
