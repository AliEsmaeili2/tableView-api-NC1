
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    var cellBtn : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func BtnTapped(_ sender: Any) {
        
        cellBtn?()
    }
}
