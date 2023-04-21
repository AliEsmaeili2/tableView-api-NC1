
import UIKit
import WebKit
import SafariServices

class webViewVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    //link webView url when loading
    let url = "https://www.dotabuff.com/heroes"
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        ActivityIndicator.startAnimating()
        
        //urlRequest
        let urlReq = URLRequest(url: URL(string: url)!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            
            self.webView.load(urlReq)
            self.ActivityIndicator.stopAnimating()
            self.ActivityIndicator.hidesWhenStopped = true
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            
            try reachability.startNotifier()
            
        }catch{
            
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
            
        case .wifi:
            print("Reachable via WiFi")
            
        case .cellular:
            print("Reachable via Cellular")
            
        case .unavailable:
            print("Network not reachable")
            
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
