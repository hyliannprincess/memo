//
//  MemoListTableViewController.swift
//  Memo
//
//  Created by Adams, Kylee B. on 2/14/23.
//

import UIKit
import UserNotifications

let notifCenter = UNUserNotificationCenter.current()

class MemoListTableViewController: UITableViewController {
    
    let formatter: Formatter = {
            let f = DateFormatter()
            f.dateStyle = .long
            f.timeStyle = .long
            return f
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            if let vc = segue.destination as? DetailViewController{
                vc.memo = DataManager.shared.memoList[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let notifCenter = UNUserNotificationCenter.current()
        notifCenter.requestAuthorization(options: [.alert,.badge,.sound,.criticalAlert]){(didAllow,error)in
            if didAllow{
                notifCenter.delegate = self
            }
            print("didAllow\(didAllow)")
        }
    }

    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.shared.readMemo()
        tableView.reloadData()
        print(#function)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataManager.shared.memoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let target = DataManager.shared.memoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = formatter.string(for:target.insertDate)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}





extension MemoListTableViewController:UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification:UNNotification,withCompletionHandler completionHandler:@escaping(UNNotificationPresentationOptions)->Void){
        completionHandler([.banner,.sound,.badge])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification:UNNotification?){
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController,animated:true,completion: nil)
    }
}
