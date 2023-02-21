
import UIKit
import WebKit
import SafariServices

class webViewVC: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    //link webView url when loading
    let url = "https://www.dotabuff.com/heroes"
    
    // MARK: - func viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //urlRequest
        let urlReq = URLRequest(url: URL(string: url)!)
        
        // MARK: - activeIndicator()
        
        func activeIndicator () {
            
            let container = UIView()
            container.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            
            let activeIndicator = UIActivityIndicatorView(style: .large)
            activeIndicator.center = self.view.center
            
            container.addSubview(activeIndicator)
            self.view.addSubview(container)
            
            activeIndicator.startAnimating()
            activeIndicator.hidesWhenStopped = true
            
            print("1-Loading URL -3sec")
            // Hide the container view and stop the indicator animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                
                //load webview
                self.webView.load(urlReq)
                print("2-URL Loaded")
                
                activeIndicator.stopAnimating()
                container.removeFromSuperview()
                
                print("3-URL Stoped")
                
            }
        }
        
        activeIndicator()
    }
    
}
