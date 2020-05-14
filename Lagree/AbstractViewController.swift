import UIKit

class AbstractViewController: UIViewController {
    
    
    var vc:UIViewController? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //Open menu
    @objc func revealMenu()
    {
        print("revealMenu")
        self.sideMenuController?.revealMenu()
    }
    
    
    //Open login controller
    @objc func goToLogin()
    {
        AbstractViewController.goToLoginController()
    }
    
    
    //Open signup controller
    @objc func goToSignup()
    {
        AbstractViewController.goToSignupController()
    }
    
    

    @objc func goToController(modifier:String){
        AbstractViewController.goToController(modifier: modifier)
    }
    
    //Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
    func pushController(id: String)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let memberDetailsViewController = storyBoard.instantiateViewController(withIdentifier: id)
        self.navigationController?.pushViewController(memberDetailsViewController, animated:true)
    }
    
    func popupController(id: String)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: id)
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .fullScreen
        self.present(popUpVC, animated: true, completion: nil)
    }
    
    func setBackground(img: String? = "accountBg"){
        
        
        let background_image_view = UIImageView()
        view.addSubview(background_image_view)
        background_image_view.translatesAutoresizingMaskIntoConstraints = false
        background_image_view.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        background_image_view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        background_image_view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        background_image_view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        
        
        background_image_view.image = UIImage(named: img ?? "accountBg")
        
        
        view.sendSubview(toBack: background_image_view)
    }
    
    
    //Open login controller static
    static func goToLoginController(animationType:AnimationType = .ANIMATE_UP) {
        DispatchQueue.main.async(execute: {
            
            
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            window.showViewControllerWith(withIdentifier: "LoginController", usingAnimation: animationType, menu: false)
            
            
        })
    }
    
    
    static func goToSignupController(animationType:AnimationType = .ANIMATE_UP) {
        DispatchQueue.main.async(execute: {
            
            
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            window.showViewControllerWith(withIdentifier: "SignupController", usingAnimation: animationType, menu: false)
            
            
        })
        
    }
    

    
    static func goToController(animationType:AnimationType = .ANIMATE_LEFT, modifier: String, menu:Bool = false) {
        DispatchQueue.main.async(execute: {
            
            
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            window.showViewControllerWith(withIdentifier: modifier, usingAnimation: animationType, menu: menu)
            
            
        })
        
    }
    
    
    
  
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func addCustomProfileBar(title: String, back: String = "")
    {
        //View
        let myView = UIView(frame: CGRect(x: 0, y: 30, width:view.frame.maxX, height: 30))
        //myView.backgroundColor = UIColor.white
        
        
        //Title
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.text = title
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        //label.font = UIFont(name:"avenirNext-Meduim",size:20)
        label.center = myView.center
        label.center = CGPoint(x: label.center.x, y: label.center.y - 30 )
        myView.addSubview(label)
        label.textAlignment = .center
        
        
        
        //Back button
        let image = UIImage(named: "back") as UIImage?
        let button = MyButton(type: UIButtonType.custom) as MyButton
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        button.setImage(image, for: .normal)
        button.backController = back
        button.addTarget(self, action: #selector(backTouched(sender:)), for:.touchUpInside)
        myView.addSubview(button)
        
        
        //cancel
        let cancel = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        
        cancel.frame.origin.y = 0
        cancel.frame.origin.x = self.view.frame.width - cancel.frame.width
        
        cancel.text = "CANCEL"
        cancel.font = UIFont.boldSystemFont(ofSize: 12.0)
        cancel.textColor = UIColor.lightGray
        cancel.textAlignment = .center
        myView.addSubview(cancel)
        

//Back button
       let buyCreddits = MyButton(type: UIButtonType.custom) as MyButton
       button.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
       button.setImage(image, for: .normal)
       button.backController = back
       button.addTarget(self, action: #selector(backTouched(sender:)), for:.touchUpInside)
       myView.addSubview(button)

        
        
        
        self.view.addSubview(myView)
    }
    
    @objc func backTouched (sender: MyButton)
    {
        if sender.backController != "" {
            
            
            DispatchQueue.main.async(execute: {
                guard let window = UIApplication.shared.keyWindow else {
                    return
                }
                window.showViewControllerWith(withIdentifier: sender.backController!, usingAnimation: .ANIMATE_RIGHT, menu: false)
            })
        }
    }
    
    func displayAlertMessage(userMessage:String) {
        
        let textFieldAlert = UIAlertController(title: "Alert".localized, message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok".localized, style: .default, handler: nil)
        
        textFieldAlert.addAction(okAction)
        
        self.present(textFieldAlert, animated: true, completion: nil)
        
    }
    
    func alert(msg: String) {
        
        let transitionDelegate = AlertTransitioningDelegate()
        vc = UIViewController()
        vc!.modalPresentationStyle = .custom
        vc!.modalTransitionStyle = .coverVertical // use whatever transition you want
        vc!.transitioningDelegate = transitionDelegate
        
        //let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
        vc!.view.backgroundColor = UIColor.white
        //vc!.view = view
        vc!.view.setBorder()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        
        label.frame.origin.y = 10
        label.frame.origin.x = 0
        
        label.text = msg
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.center.x = self.view.center.x - 5
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        vc!.view.addSubview(label)
        
        
        let okButton = UIButton(type: UIButtonType.custom)
        okButton.frame = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.size.width - 10, height: 70)
        okButton.setTitle("OK", for: .normal)
        okButton.center.x = self.view.center.x - 5
        okButton.addTarget(self, action: #selector(dismissAlert), for:.touchUpInside)
        okButton.setLagreeRedColor()
        vc!.view.addSubview(okButton)
        
        
        /**let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        view.window!.layer.add(transition, forKey: kCATransition)
        self.view.addSubview(vc!.view)
        **/
        present(vc!, animated: true, completion: nil)
    }
    
    @objc func dismissAlert()
    {
        if (self.vc != nil) {
            self.vc!.dismiss(animated: true, completion: nil)
        }
    }
    
}
