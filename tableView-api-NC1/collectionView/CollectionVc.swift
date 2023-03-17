
import UIKit

class CollectionVc: UIViewController, UICollectionViewDelegate,  UISearchBarDelegate {
    
    var heroes = [Hero]()
    var heroesStack = [Hero]()
    
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView1.delegate = self
        self.collectionView1.dataSource = self
        
        APIImages(URL: "https://api.opendota.com/api/heroStats") { result in
            self.heroes = result
            self.heroesStack = result
            
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
    
    // MARK: - Fetching API
    
    func APIImages(URL url:String, completion: @escaping ([Hero]) -> Void) {
        
        activityIndicator.startAnimating()
        
        let url = URL(string: url)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data,response,error) in
            
            do {
                
                let fetchingData = try JSONDecoder().decode([Hero].self, from:data!)
                completion(fetchingData)
                
                DispatchQueue.main.async {
                    
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.hidesWhenStopped = true
                    self.collectionView1.reloadData()
                }
                
            } catch {
                
                print("Parsing Error")
            }
        }
        
        dataTask.resume()
    }
    
    // MARK: - Segment Control
    
    @IBAction func didTabSegment(_ sender: UISegmentedControl) {
        
        heroesStack.removeAll()
        
        if sender.selectedSegmentIndex == 0 {
            
            heroesStack = heroes
        }
        
        if sender.selectedSegmentIndex == 1  {
            
            heroesStack = heroes.filter({ $0.attack_type.starts(with: "R")}) //Ranged
        }
        
        else if sender.selectedSegmentIndex == 2  {
            
            heroesStack = heroes.filter({ $0.attack_type.starts(with: "M")}) //Melee
        }
        
        else if sender.selectedSegmentIndex == 3  {
            
            heroesStack = heroes.filter({ $0.primary_attr.starts(with: "s")}) //str
        }
        
        else if sender.selectedSegmentIndex == 4  {
            
            heroesStack = heroes.filter({ $0.primary_attr.starts(with: "a")}) //agi
        }
        
        else if sender.selectedSegmentIndex == 5  {
            
            heroesStack = heroes.filter({ $0.primary_attr.starts(with: "i")}) //int
        }
        
        collectionView1.reloadData()
    }
}
// MARK: - Struct & Connect-> CollectionView-Datasource [CELL]

extension CollectionVc : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return heroesStack.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.NameLabel.text = heroesStack[indexPath.row].localized_name
        
        let apiData : Hero
        apiData = heroesStack[indexPath.row]
        
        let string = "https://api.opendota.com" + (apiData.img)
        let url = URL(string: string)
        
        cell.apiImage.downloaded(from: url!, contentMode: .scaleToFill)
        cell.apiImage.layer.cornerRadius = cell.apiImage.frame.height / 10
        
        return cell
        
    }
}

// MARK: - download API Image

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                    
            else { return }
            
            DispatchQueue.main.async() {
                
                [weak self] in self?.image = image
            }
            
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        
        guard let url = URL(string: link) else { return }
        
        downloaded(from: url, contentMode: mode)
    }
}
