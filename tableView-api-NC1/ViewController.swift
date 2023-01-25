

import UIKit

class ViewController: UIViewController {
    

    var data = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        APIImages(URL: "https://api.opendota.com/api/heroStats") { result in print(result)}
    }
    
    
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

