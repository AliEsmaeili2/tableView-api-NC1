
import UIKit

class TableVc: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //connect tableView in main.storyboard to ViewController
    
   @IBOutlet weak var searchBar: UISearchBar!
    
    var heroes = [HeroStats]()
    
   // var searchingNames = [String]()
  //  var searching = false
    
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
        
        
  //      if searching {
            
 //           return searchingNames.count
            
  //      } else {
            
            return heroes.count
 //       }
    }
    
    // for CellRow ->take(img & HeroName)in TableView From JSON(API) for Load to CustomTableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        
        let apiData : HeroStats
        apiData = heroes[indexPath.row]
        
        //for load img from JSON
        let string = "https://api.opendota.com" + (apiData.img)
        let url = URL(string: string)
        
        cell.imageCell.downloadedFrom(url: url!, contentMode: .scaleToFill)
        cell.nameCell.text = apiData.localized_name
        
        /*
       if searching {
            
            cell.nameCell.text = searchingNames[indexPath.row]

            
        } else {
            
            cell.nameCell.text = heroes[indexPath.row].localized_name
            
        }
         */
    
        // for Button
        cell.cellBtn = {[unowned self] in
            
            let listName = self.heroes[indexPath.row].localized_name
            let listAtt = self.heroes[indexPath.row].primary_attr
            let listAttack_type = self.heroes[indexPath.row].attack_type

            
            
            let alert = UIAlertController(title: "\(listName)", message: "Primary_Attribute: \(listAtt) \n Attack_Type: \(listAttack_type)", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(alertAction)
            
            present(alert, animated: true, completion: nil)
        }
        
        return cell
    }
    
        /*
        
        func searchBar(_ searchBar : UISearchBar, textDidChange searchText: String){
            
            searchingNames = heroes.filter({$0.prefix(searchText.count) == searchText})
            
             searching = true
            tableView.reloadData()
        }
    
    func searchBarCancelButtonClicked(_ searchBar : UISearchBar) {
        
        searching = false
        searchBar.text = ""
    }
*/
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
