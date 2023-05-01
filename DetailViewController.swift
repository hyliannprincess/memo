//
//  DetailViewController.swift
//  Memo
//
//  Created by Adams, Kylee B. on 3/7/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    let formatter: Formatter = {
            let f = DateFormatter()
            f.dateStyle = .long
            f.timeStyle = .long
            return f
    }()
    var memo: Memo?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension DetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    switch indexPath.row{
        case 0:
            let Cell_1 = tableView.dequeueReusableCell(withIdentifier: "MemoCell",for: indexPath)
            print("MemoCell row\(indexPath.row)")
            print("MemoCell section\(indexPath.section)")
            Cell_1.textLabel?.text = memo?.content
            return Cell_1
        
        case 1:
            let Cell_2 = tableView.dequeueReusableCell(withIdentifier: "DateCell",for: indexPath)
            print("DateCell row \(indexPath.row)")
            print("DateCell section \(indexPath.section)")
            Cell_2.textLabel?.text = formatter.string(for:memo?.insertDate)
            return Cell_2
        
        default:
            fatalError()
        }
    }
 
}
