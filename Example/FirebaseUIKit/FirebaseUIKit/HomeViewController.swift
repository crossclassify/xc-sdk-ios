import UIKit
import FirebaseAuth
import CrossClassify

class HomeViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    let options = ["Edit Profile", "Log out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CrossClassify.shared.track(pageName: "home", view: view)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        CrossClassify.shared.stopTrack()
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section:
                   Int) -> Int {
        
        return options.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath:
                   IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell (style: .default, reuseIdentifier: "cel")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0) {
            performSegue(withIdentifier: "editProfile", sender: self)
        }
        else {
            do {
                try Auth.auth().signOut()
                navigationController?.popViewController(animated: true)
            } catch let signOutError as NSError{
                print(signOutError)
            }
        }
    }
}
