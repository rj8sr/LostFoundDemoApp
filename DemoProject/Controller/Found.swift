

import UIKit
import SQLite3

 
class Found: UIViewController
{
    var lostfound :[LostFound] = []
    var searchedData :[LostFound] = []
   
     var searching = false
    var db: OpaquePointer?
       
  var stmt: OpaquePointer?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let transiton = SlideInTransition()
          var topView: UIView?
       override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "The Found List"
   
    
   let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
         .appendingPathComponent("LostANDFound.sqlite")
     if sqlite3_open(fileURL.path, &db) != SQLITE_OK
     {
         print("error opening database")
        
     } else {
     print("Successfully  open connection to database.\(fileURL)")
     
   }
    if sqlite3_prepare_v2(db, "CREATE TABLE IF NOT EXISTS LostFound (name TEXT, itemname TEXT, lostdate TEXT , place TEXT , mobile TEXT );" , -1 , &stmt , nil) == SQLITE_OK {
       if sqlite3_step(stmt) == SQLITE_DONE
           {
               print("LostFound table created.")
           } else {
               print("LostFound table could not be created.")
           }
       }
    else {
           print("CREATE TABLE statement could not be prepared.")
       }
    sqlite3_finalize(stmt)
               
       readValues()
   
    self.navigationItem.setHidesBackButton(true, animated: false)
   
  
    
  
    }
    
   
    func readValues(){
    lostfound.removeAll()
 let queryString = "SELECT * FROM LostFound;"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) == SQLITE_OK{
             while sqlite3_step(stmt) == SQLITE_ROW {
let name = String(describing: String(cString: sqlite3_column_text(stmt, 0)))
let itemname = String(describing: String(cString: sqlite3_column_text(stmt, 1)))
let finddate = String(describing: String(cString: sqlite3_column_text(stmt, 2)))
let place = String(describing: String(cString: sqlite3_column_text(stmt, 3)))
                
let mobile = String(describing: String(cString: sqlite3_column_text(stmt, 4)))
                       lostfound.append(LostFound(name: name , itemname:itemname, finddate: finddate, place:place , mobile: mobile))
                print("\(String(describing: name))|  \(String(describing: itemname)) |\(String(describing:finddate)) | \(String(describing: place))|\(String(describing:mobile))  ")
                   }
        }else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(stmt)
        
       
        
        self.tableView.reloadData()
    }
    @IBAction func Slideout(_ sender: UIBarButtonItem) {
      guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
               menuViewController.didTapMenuType = { menuType in
                   self.transitionToNew(menuType)
               }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
               present(menuViewController, animated: true)
        
        
    }
    func transitionToNew(_ menuType: MenuType) {
          topView?.removeFromSuperview()
           switch menuType {
            case .home:
            let view = UIView()
            let sigt : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let sam = sigt.instantiateViewController(withIdentifier: "CustomTable") as! CustomTableViewController
             navigationController?.pushViewController(sam, animated: false)
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
           case .lost:
               let view = UIView()
               let sigt : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let sam = sigt.instantiateViewController(withIdentifier: "infoo") as! Lost
                 navigationController?.pushViewController(sam, animated: false)
               view.frame = self.view.bounds
               self.view.addSubview(view)
               self.topView = view
           case .found:
               let view = UIView()
               view.frame = self.view.bounds
               self.view.addSubview(view)
               self.topView = view
           
           }
       }
       
     @IBAction func addName(_ sender: UIBarButtonItem) {
       let alert = UIAlertController(title: "Request For Lost Item",
               message: "Enter Your Name,Item Name,Date of Lost,Place & Mobile No. ",
               preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.textFields![0].placeholder = "Enter Your Name"
        alert.textFields![1].placeholder = "Enter Item Name"
        alert.textFields![2].placeholder = "Enter Date of Lost(dd-MM-YYYY)"
        alert.textFields![3].placeholder = "Enter Place where you lost"
        alert.textFields![4].placeholder = "Enter your Mobile Number"
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            (action) -> Void in
                   
            let name:NSString = alert.textFields![0].text! as NSString
            let itemName:NSString = alert.textFields![1].text! as NSString
            let lostdate:NSString = alert.textFields![2].text! as NSString
            let place :NSString = alert.textFields![3].text! as NSString
            let mobile :NSString = alert.textFields![4].text! as NSString
         
            var stmt: OpaquePointer?
    
     
            
            let queryString = "INSERT INTO LostFoundLost (name, itemname, finddate, place, mobile) VALUES (?,?,?,?,?);"
            
            
             if sqlite3_prepare_v2(self.db, queryString, -1, &stmt, nil) == SQLITE_OK
             {
                sqlite3_bind_text(stmt, 1, name.utf8String, -1, nil)
                sqlite3_bind_text(stmt, 2, itemName.utf8String, -1, nil)
                sqlite3_bind_text(stmt, 3, lostdate.utf8String,-1,nil)
                sqlite3_bind_text(stmt, 4, place.utf8String, -1, nil)
                sqlite3_bind_text(stmt, 5, mobile.utf8String,-1,nil)
            
                         if sqlite3_step(stmt) == SQLITE_DONE {
                          print("Successfully inserted row.")
                        }
                
            }
             else{
                print("INSERT statement could not be prepared.")

                
                
            }
            sqlite3_finalize(stmt)
            alert.textFields![0].text = ""
            alert.textFields![1].text = ""
            alert.textFields![2].text = ""
            alert.textFields![3].text = ""
            alert.textFields![4].text = ""
                        
            self.readValues()

                        print("data saved successfully")
                    }))
            
            
   
    
               // Cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            
            print("cancel")
            
        }
        ))
               
               
        self.present(alert, animated: true)
       }
    
  
   
}

    extension Found: UIViewControllerTransitioningDelegate {
        func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transiton.isPresenting = true
            return transiton
        }

        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transiton.isPresenting = false
            return transiton
        }
    }
extension Found : UISearchBarDelegate {
  
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
    searchedData =   lostfound.filter{$0.itemname.localizedCaseInsensitiveContains(searchText)}
   
    if(searchedData.count == 0){
        searching = false;
    } else {
        searching = true;
    }
   
      tableView.reloadData()
    
    
    
    }
    
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      searching = false
      searchBar.text = ""
      tableView.reloadData()
  }
  
      }

extension Found :UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          if searching {
              return searchedData.count
          } else {
              return lostfound.count
          }       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier:"cells")
        if searching
        {
            cell.textLabel?.text = "Name: " + searchedData[indexPath.row].name + "    ItemName:" + searchedData[indexPath.row].itemname
            cell.detailTextLabel?.text = " FindDate: " + searchedData[indexPath.row].finddate + "   " + " , Place: " + searchedData[indexPath.row].place + "   , Mobile: " + searchedData[indexPath.row].mobile
            
        }
        
        else{
           cell.textLabel?.text = " Name:   " + lostfound[indexPath.row].name + " , ItemName: " + lostfound[indexPath.row].itemname
           cell.detailTextLabel?.text = " FindDate: " + lostfound[indexPath.row].finddate + "   " + " , Place: " + lostfound[indexPath.row].place + "   , Mobile: " + lostfound[indexPath.row].mobile
        }
           return cell
          
       }
    
    
}

