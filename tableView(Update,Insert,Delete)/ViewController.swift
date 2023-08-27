//
//  ViewController.swift
//  tableView(Update,Insert,Delete)
//
//  Created by Ahmed Fathi on 31/07/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrNames = [Item]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell" , for: indexPath)
        cell.textLabel?.text = arrNames[indexPath.row].title
        return cell
    }
    
    @IBOutlet weak var tabelView: UITableView!
    
    @IBOutlet weak var txtUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.dataSource = self
        tabelView.delegate = self
        saveItem()
        loadItem()
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let textField = txtUserName.text
        let newitem = Item(context: self.context)
        newitem.title = textField
        self.arrNames.append(newitem)
        tabelView.reloadData()
       txtUserName.text = ""
      
        saveItem()
        loadItem()
        
        
        
        
//        if var text = txtUserName.text {
//            arrNames.append(text)
//            let add = IndexPath(row: arrNames.count - 1, section: 0)
//            tabelView.beginUpdates()
//            tabelView.insertRows(at: [add], with: .automatic)
//            tabelView.endUpdates()
//            txtUserName.text = ""
//        }
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        tabelView.isEditing =  !tabelView.isEditing
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        arrNames.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { _, _, completionHandeler in
            
            let personToRemove = self.arrNames[indexPath.row]
            self.context.delete(personToRemove)
            self.saveItem()
            self.loadItem()
        }
        let addFavorite = UIContextualAction(style: .normal, title: "favorite") { _,_,_ in
            print("add this to Favorite")
        }
        
        
        
        addFavorite.image = UIImage(systemName: "heart")
        
        return UISwipeActionsConfiguration(actions: [deleteAction,addFavorite])
    }
    func saveItem (){
        do{
            try context.save()
            
        } catch  {
            print("error saving the message\(error)")
          
        }
        tabelView.reloadData()
    }
    func loadItem(){
       
        do
        {
            arrNames = try context.fetch(Item.fetchRequest())
            tabelView.reloadData()
        } catch {
            print("erorr")
        }
    }
}

