
import UIKit

class TableVc: UIViewController ,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - variable defining
    
    var heroes = [HeroStats]()
    var filteredHeroes = [HeroStats]()
    var searchBar = UISearchBar()
    
    // MARK: - func viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //searchBar controlls
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search heroes"
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        
        //call func
        activeIndicator()
    }
    
    // MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredHeroes = searchText.isEmpty ? heroes : heroes.filter { (hero: HeroStats) -> Bool in
            return hero.localized_name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Activity Indicator View
    
    func activeIndicator () {
        
        let container = UIView()
        
        container.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        let activeIndicator = UIActivityIndicatorView(style: .large)
        
        activeIndicator.center = self.view.center
        //activeIndicator.color = .red
        
        container.addSubview(activeIndicator)
        self.view.addSubview(container)
        
        activeIndicator.startAnimating()
        activeIndicator.hidesWhenStopped = true
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            UIApplication.shared.endIgnoringInteractionEvents()
            activeIndicator.stopAnimating()
        }
    }
    
    // MARK: - Struct & Connect-> TableView to main.storyboard
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchBar.text?.isEmpty == true ? heroes.count : filteredHeroes.count
        //  return heroes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let apiData : HeroStats
        
        apiData = searchBar.text?.isEmpty == true ? heroes[indexPath.row] : filteredHeroes[indexPath.row]
        // apiData = heroes[indexPath.row]
        
        //for load img from JSON
        let string = "https://api.opendota.com" + (apiData.img)
        let url = URL(string: string)
        
        cell.imageCell.downloadedFrom(url: url!, contentMode: .scaleToFill)
        cell.nameCell.text = apiData.localized_name
        
        // for Button
        cell.cellBtn = {[unowned self] in
            
            let listName = self.heroes[indexPath.row].localized_name
            let role = self.heroes[indexPath.row].roles
            
            let alert = UIAlertController(title: "\(listName)", message: "Roles:\(role)", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(alertAction)
            
            present(alert, animated: true, completion: nil)
        }
        
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
