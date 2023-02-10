
import UIKit
import SafariServices
import WebKit

class SettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var darkModeSwitch: UISwitch!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Check if dark mode is already enabled
//        if UserDefaults.standard.bool(forKey: "DarkModeEnabled") {
//            darkModeSwitch.isOn = true
//            enableDarkMode()
//        }
//    }
//
//    @IBAction func switchChanged(_ sender: UISwitch) {
//        if sender.isOn {
//            enableDarkMode()
//        } else {
//            enableLightMode()
//        }
//    }
//
//    func enableDarkMode() {
//        UserDefaults.standard.set(true, forKey: "DarkModeEnabled")
//        view.backgroundColor = .darkGray
//        navigationController?.navigationBar.barTintColor = .black
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//    }
//
//    func enableLightMode() {
//        UserDefaults.standard.set(false, forKey: "DarkModeEnabled")
//        view.backgroundColor = .white
//        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.
//


    //..................................................................
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var darkModeSwitch: UISwitch!
//    @IBOutlet weak var textLabel: UILabel!
//
//    var isDarkMode = false {
//        didSet {
//            updateUI()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        darkModeSwitch.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
//    }
//
//    @objc func switchValueDidChange() {
//        isDarkMode = darkModeSwitch.isOn
//    }
//
//    func updateUI() {
//        view.backgroundColor = isDarkMode ? .black : .white
//        textLabel.textColor = isDarkMode ? .white : .black
//        navigationController?.navigationBar.barTintColor = isDarkMode ? .black : .white
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: isDarkMode ? UIColor.white : UIColor.black]
//    }
//}
//You can create a dark mode and light mode switch in Swift 5 by using a UISwitch and a boolean value to determine whether the app is in dark mode or light mode. You can change the appearance of your views and navigation bar depending on the value of this boolean.
//



//...............................................................................
//
// In your view controller
//
//private let lightModeKey = "lightMode"
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Set up the switch
//    let switchControl = UISwitch()
//    switchControl.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
//
//    // Check if light mode is on
//    let isLightModeOn = UserDefaults.standard.bool(forKey: lightModeKey)
//    switchControl.isOn = isLightModeOn
//
//    // Set up the bar button item for the switch
//    let switchItem = UIBarButtonItem(customView: switchControl)
//    navigationItem.rightBarButtonItem = switchItem
//
//    // Update the view's appearance based on the switch state
//    updateAppearance(for: isLightModeOn)
//}
//
//@objc func switchChanged(sender: UISwitch) {
//    UserDefaults.standard.set(sender.isOn, forKey: lightModeKey)
//    updateAppearance(for: sender.isOn)
//}
//
//private func updateAppearance(for isLightModeOn: Bool) {
//    if isLightModeOn {
//        // Set up the appearance for light mode
//        view.backgroundColor = .white
//        navigationController?.navigationBar.barStyle = .default
//    } else {
//        // Set up the appearance for dark mode
//        view.backgroundColor = .darkGray
//        navigationController?.navigationBar.barStyle = .black
//    }
//}
// This code creates a switch and sets it up as a right bar button item in the navigation bar. The state of the switch is saved in UserDefaults so that it persists between launches of the app. The switchChanged method is called when the user taps the switch, and it updates the appearance of the view based on the new state of the switch.