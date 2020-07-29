

import UIKit

enum MenuType: Int {
    case home
    case lost
    case found
}

class MenuViewController: UITableViewController {
    var topView: UIView?
var didTapMenuType: ((MenuType) -> Void)?
      override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
      guard let menuType = MenuType(rawValue: indexPath.row) else {
        return }
       dismiss(animated: true) { [weak self] in
        // print("Dismissing: \(menuType)")
         self?.didTapMenuType?(menuType)
      }
    }
   
 
    
    
    
 
    
    
}
