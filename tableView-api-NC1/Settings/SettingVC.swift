
import UIKit
import SafariServices
import WebKit

class SettingVC: UIViewController {
    
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var textLabelMode : UILabel!
    @IBOutlet weak var textLabelWeb  : UILabel!
    @IBOutlet weak var viewMode      : UIView!
    @IBOutlet weak var viewWeb       : UIView!
    
    var isDarkMode = false {
        
        didSet {
            
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkModeSwitch.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
    }
    
    @objc func switchValueDidChange() {
        
        isDarkMode = darkModeSwitch.isOn
    }
    
    func updateUI() {
        
        view.backgroundColor     = isDarkMode ? .darkGray : .white
        textLabelMode.textColor  = isDarkMode ? .white    : .black
        textLabelWeb.textColor   = isDarkMode ? .white    : .black
        viewMode.backgroundColor = isDarkMode ? .gray     : .systemGray5
        viewWeb.backgroundColor  = isDarkMode ? .gray     : .systemGray5
        
        navigationController?.navigationBar.barTintColor        = isDarkMode ? .black : .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: isDarkMode ? UIColor.white : UIColor.black]
    }
}
