//
//  UserListViewController.swift
//  DemoCore
//
//  Created by Saumil on 23/07/24.
//

import UIKit

class UserListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tblUser: UITableView!
    
    // MARK: - Class Properties
    
    var arrUser: [Student] = [] // hamesha array intity no levo, modal no nai aave array
    
    // MARK: - Life Cycle Functions
    
    
    // MARK: - Memory Management Functions
    
    
    // MARK: - Class Functions
    
    func setupUI() {
        self.tblUser.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
    }
    
    
    
    // MARK: - Action Function
    
    @IBAction func adduserButonTapped(_ sender: Any) {
        addNavigation()
    }
    
    func addNavigation(user: Student? = nil) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Web Service Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrUser = CoreDataManager.shared.fetchUserData()
        self.tblUser.reloadData()
    }
}

extension UserListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblUser.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        if let image = CoreDataManager.shared.loadImageFromDocumentsDirectory(fileName: arrUser[indexPath.row].imgName ?? "") {
            cell.imgUser.image = image
        } else {
            cell.imgUser.image = nil  // Handle the case where the image isn't found
        }
        cell.txtName.text = arrUser[indexPath.row].name
        cell.txtAddress.text = arrUser[indexPath.row].address
        cell.txtCity.text = arrUser[indexPath.row].city
        cell.txtMobileNumber.text = arrUser[indexPath.row].mobile
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.addNavigation(user: self.arrUser[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            CoreDataManager.shared.deleteUser(userEntity: self.arrUser[indexPath.row])
            
            self.arrUser.remove(at: indexPath.row)
            self.tblUser.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}
