
import UIKit
import WebKit
import SafariServices

class webViewVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    //link webView url when loading
    let url = "https://www.dotabuff.com/heroes"
    
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
        
        if Connectivity.isConnectedToInternet() {
            
            print("Device is connected to the internet")
            
        } else {
            
            // Device is not connected to the internet
            print("Device is not connected to the internet")
            
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
}
