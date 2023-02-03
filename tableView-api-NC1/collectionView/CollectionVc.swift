
import UIKit
import WebKit
import SafariServices

class CollectionVc: UIViewController, UICollectionViewDelegate,  UISearchBarDelegate {
    
    var heroes = [Hero]()
    
    @IBOutlet weak var collectionView1: UICollectionView!
    // Connect collectionView in main.storyboard to CollectionVC(viewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView1.delegate = self
        self.collectionView1.dataSource = self
        
        APIImages(URL: "https://api.opendota.com/api/heroStats") { result in
            self.heroes = result
            
            DispatchQueue.main.async {
                
                self.collectionView1.reloadData()
            }
        }
    }
    // MARK: - Fetching API
    
    func APIImages(URL url:String, completion: @escaping ([Hero]) -> Void) {
        
        let url = URL(string: url)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data,response,error) in
            
            do {
                
                let fetchingData = try JSONDecoder().decode([Hero].self, from:data!)
                completion(fetchingData)
                
            } catch {
                
                print("Parsing Error")
            }
            
            //            DispatchQueue.main.sync {
            //                print(self.heroes.count)
            //            }
        }
        
        dataTask.resume()
    }
}
// MARK: - Struct & Connect-> CollectionView-Datasource

extension CollectionVc : UICollectionViewDataSource {
    
    
    //   func numberOfSections(in collectionView: UICollectionView) -> Int {
    //     return 3
    //  }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.NameLabel.text = heroes[indexPath.row].localized_name
        
        let apiData : Hero
        apiData = heroes[indexPath.row]
        
        let string = "https://api.opendota.com" + (apiData.img)
        let url = URL(string: string)
        
        cell.apiImage.downloaded(from: url!, contentMode: .scaleToFill)
        cell.apiImage.layer.cornerRadius = cell.apiImage.frame.height / 10
        
        return cell
    }
    
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        print("index is : \(indexPath.row)")
    //        performSegue(withIdentifier: "HeroPageSegue", sender: nil)
    //    }
    
    //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    //  }
    
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
