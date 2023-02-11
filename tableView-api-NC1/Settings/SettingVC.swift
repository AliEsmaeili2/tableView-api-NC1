
import UIKit
import SafariServices
import WebKit

class SettingVC: UIViewController {
    
    private let lightModeKey = "lightMode"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the switch
        let switchControl = UISwitch()
        switchControl.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        // Check if light mode is on
        let isLightModeOn = UserDefaults.standard.bool(forKey: lightModeKey)
        switchControl.isOn = isLightModeOn
        
        // Set up the bar button item for the switch
        let switchItem = UIBarButtonItem(customView: switchControl)
        navigationItem.rightBarButtonItem = switchItem
        
        // Update the view's appearance based on the switch state
        updateAppearance(for: isLightModeOn)
    }
    
    @objc func switchChanged(sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: lightModeKey)
        updateAppearance(for: sender.isOn)
    }
    
    private func updateAppearance(for isLightModeOn: Bool) {
        if isLightModeOn {
            // Set up the appearance for light mode
            view.backgroundColor = .white
            
            navigationController?.navigationBar.barStyle = .black
        } else {
            // Set up the appearance for dark mode
            view.backgroundColor = .darkGray
            navigationController?.navigationBar.barStyle = .default
        }
    }
}
