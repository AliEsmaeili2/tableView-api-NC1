
import UIKit

// MARK: - Download image From URL

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            
                else { return }
            
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloadedFrom( link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
// MARK: - Connect img & Lbl from main.story to HeroViewController

class HeroViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var attributeLabel: UILabel!
    
    @IBOutlet weak var attackLabel: UILabel!
    
    @IBOutlet weak var legsLabel: UILabel!
    
    @IBOutlet weak var healthLabel: UILabel!
    
    @IBOutlet weak var manaLabel: UILabel!
        
    @IBOutlet weak var strLabel: UILabel!
    
    @IBOutlet weak var agiLabel: UILabel!
    
    @IBOutlet weak var intLabel: UILabel!
    
    @IBOutlet weak var rangeLabel: UILabel!
    
    @IBOutlet weak var moveLabel: UILabel!
    
    @IBOutlet weak var attackMinLabel: UILabel!
    
    @IBOutlet weak var attackMaxLabel: UILabel!
    
    
    var hero : HeroStats?
    
    // MARK: - Show & exchange Lbl and Varible to main.story
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        nameLabel.text = hero?.localized_name
        attributeLabel.text = hero?.primary_attr
        attackLabel.text = hero?.attack_type
        legsLabel.text = "\((hero?.legs)!)"
        healthLabel.text = "\((hero?.base_health)!)"
        manaLabel.text = "\((hero?.base_mana)!)"
        strLabel.text = "\((hero?.base_str)!)"
        agiLabel.text = "\((hero?.base_agi)!)"
        intLabel.text = "\((hero?.base_int)!)"
        rangeLabel.text = "\((hero?.attack_range)!)"
        moveLabel.text = "\((hero?.move_speed)!)"
        attackMinLabel.text = "\((hero?.base_attack_min)!)"
        attackMaxLabel.text = "\((hero?.base_attack_max)!)"
        //armorLabel.text = "\((hero?.base_armor)!)"
         
        let urlString = "https://api.opendota.com"+(hero?.img)!
        let url = URL(string: urlString)
        imageView.downloadedFrom(url : url!)
    }
}
