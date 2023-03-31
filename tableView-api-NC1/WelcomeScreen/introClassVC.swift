
import UIKit

class introClassVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if Core.shared.isNewUser() {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "welcome") as! WelcomeVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

class Core {
    
    static let shared = Core()
    
    func isNewUser() -> Bool {
        
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func isNotNewUser() {
        
        return UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
