//
//  SecondViewController.swift
//  SwiftCoreData
//
//  Created by DigitalFlake Kapil Dongre on 23/09/23.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {
    var context = NSManagedObjectContext()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData()
    }
    func fetchData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            for data in result{
                debugPrint((data as AnyObject).value(forKey: "name") as! String)
                debugPrint((data as AnyObject).value(forKey: "id") as! Int16)
                debugPrint((data as AnyObject).value(forKey: "age") as! Int32)
                
            }
        }catch{
        }
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
