
import UIKit

class CollectionVc: UIViewController {
    
    var data = [ToDo]()
    
    @IBOutlet weak var collectionView1: UICollectionView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
                
        APIImages(URL: "https://api.opendota.com/api/heroStats") { result in
            self.data = result
            DispatchQueue.main.async {
                
                self.collectionView1.reloadData()
            }
        }
    }
    
    // MARK: - Fetching API

    
    func APIImages(URL url:String, completion: @escaping ([ToDo]) -> Void) {
        
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data,response,error in
                do {
                    let fetchingData = try JSONDecoder().decode([ToDo].self, from:data!)
                    completion(fetchingData)
                } catch {
                    
                    print("Parsing Error")
                }
            }
            dataTask.resume()

        }
    }

extension CollectionVc : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let apiData : ToDo
        apiData = data[indexPath.row]
        
        let string = "https://api.opendota.com" + (apiData.img)
        let url = URL(string: string)
        
        cell.apiImage.downloaded(from: url!, contentMode: .scaleToFill)
        
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
