
import UIKit

class TableVc: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    //connect tableView in main.storyboard to ViewController
    
    var heroes = [HeroStats]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
    
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Struct & Connect-> TableView to main.storyboard

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return heroes.count
    }
    
    // for CellRow ->take(img & HeroName)in TableView From JSON(API) for Load to CustomTableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
    
        let apiData : HeroStats
        apiData = heroes[indexPath.row]
        
        let string = "https://api.opendota.com" + (apiData.img)
        let url = URL(string: string)
        
        cell.imageCell.downloadedFrom(url: url!, contentMode: .scaleToFill)
        cell.nameCell.text = apiData.localized_name
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? HeroVC {
            destination.hero = heroes[tableView.indexPathForSelectedRow!.row]
        }
    }
    // MARK: - Download JSON

    func downloadJSON(completed: @escaping () -> ()){
        
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                
                do {
                    self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
         
                } catch {
                
                        print("JSON Error!")
                }
            }
        }.resume()
    }
}
