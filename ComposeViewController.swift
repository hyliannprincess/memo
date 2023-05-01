//
//  ComposeViewController.swift
//  Memo
//
//  Created by Adams, Kylee B. on 2/14/23.
//

import UIKit

class ComposeViewController: UIViewController {

    
    @IBAction func cancelBttn(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
    
    @IBAction func saveBttn(_ sender: Any) {
        guard let memo = memoTextView.text, memo.count > 0
        else{
            alert(message: "Write Text!")
            return
        }
        DataManager.shared.saveMemo(memo)
        
        let content = UNMutableNotificationContent()
        content.title = "Title:UserNotification"
        content.subtitle = "Subtitle:PRESS_UserNotification"
        content.body = "Body:SetUp UserNotification"
        content.badge = 1
        
        let TimeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.2, repeats: false)
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: TimeIntervalTrigger)
        
        notifCenter.add(request,withCompletionHandler: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1.View did load")
        print("===========")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2.View will appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3. View did appear")
        print("============")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("4.View will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("5.View did disappear")
        print("============")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
