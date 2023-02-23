
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
        
    }
    
}
