
import UIKit

class TableVc: UIViewController ,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var heroes         = [HeroStats]()
    var filteredHeroes = [HeroStats]()
    var searchBar      = UISearchBar()
    let reachability = try! Reachability()
    
    // MARK: - func viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            
            self.filteredHeroes = self.heroes
            
            //  self.tableView.reloadData()
            // self.activeIndicator()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //searchBar controlls
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search heroes"
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        
        searchBar.showsCancelButton = true
        searchBar.setShowsCancelButton(true, animated: false)
    }
    // MARK: - func viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            
            try reachability.startNotifier()
            
        }catch{
            
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            
        case .cellular:
            print("Reachable via Cellular")
            
        case .unavailable:
            print("Network not reachable")
            
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        // Clear search bar text
        searchBar.text = ""
        
        // Hide cancel button
        //  searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        // Restore filteredHeroes to the original heroes array
        filteredHeroes = heroes
        
        tableView.reloadData()
    }
    
    // MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredHeroes = searchText.isEmpty ? heroes : heroes.filter { (hero: HeroStats) -> Bool in
            return hero.localized_name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Struct & Connect-> TableView to main.storyboard
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //0  return heroes.count
        //1  return searchBar.text?.isEmpty == true ? heroes.count : filteredHeroes.count
        return filteredHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        //1 let apiData : HeroStats
        //1 apiData = searchBar.text?.isEmpty == true ? heroes[indexPath.row] : filteredHeroes[indexPath.row]
        //0 apiData = heroes[indexPath.row]
        
        //2
        let apiData = filteredHeroes[indexPath.row]
        
        //for load img from JSON
        let string = "https://api.opendota.com" + (apiData.img)
        let url = URL(string: string)
        
        cell.imageCell.downloadedFrom(url: url!, contentMode: .scaleToFill)
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.height / 2
        cell.nameCell.text = apiData.localized_name
        
        // for Button
        cell.cellBtn = {[unowned self] in
            
            let listName = self.filteredHeroes[indexPath.row].localized_name
            let role = self.filteredHeroes[indexPath.row].roles
            
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
            
            destination.hero = filteredHeroes[tableView.indexPathForSelectedRow!.row]
            
        }
    }
    // MARK: - Download JSON
    
    func downloadJSON(completed: @escaping () -> ()){
        
        ActivityIndicator.startAnimating()
        
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                
                do {
                    self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
                    
                    DispatchQueue.main.async {
                        
                        completed()
                        
                        self.ActivityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    
                    print("JSON Error!")
                }
            }
        }.resume()
    }
}
