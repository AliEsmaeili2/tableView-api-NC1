
import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet var holderView: UIView!
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configure()
    }
    
    private func configure() {
        
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        let titles = ["Welcome To Dota2 Heroes","List of Heroes","Type of Heroes"]
        
        for x in 0..<3 {
            
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            
            scrollView.addSubview(pageView)
            
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width-20, height: 120))
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10+120+10, width: pageView.frame.size.width-20, height: pageView.frame.size.height - 60 - 130 - 15))
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height-60, width: pageView.frame.size.width-20, height: 50))
            
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 28)
            pageView.addSubview(label)
            label.text = titles[x]
            
            imageView.contentMode = .scaleAspectFit
          //  imageView.image = UIImage(named: "welcome-\(x + 1)")
            pageView.addSubview(imageView)
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .darkGray
            button.setTitle("NEXT", for: .normal)
            
            if x == 2 {
                button.setTitle("GET STARTED!", for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .systemGreen
            }
            
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = x + 1
            pageView.addSubview(button)
        }
        
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    @objc func didTapButton(_ button: UIButton) {
        
        //   guard button.tag < 3 else {
        if button.tag == 3 {
            //dismiss
            
            
            Core.shared.isNotNewUser()
            dismiss(animated: true, completion: nil)
    
            performSegue(withIdentifier: "showTableView", sender: self)

            
        }
     //   return

        //Scroll to next page
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag) , y: 0), animated: true)
        
    }
}
