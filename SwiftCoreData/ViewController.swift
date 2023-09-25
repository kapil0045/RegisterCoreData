//
//  ViewController.swift
//  SwiftCoreData
//
//  Created by DigitalFlake Kapil Dongre on 23/09/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var studIdTxtField: UITextField!
    
    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var ageTxtField: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context = NSManagedObjectContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       

        setupTextFields()
        registerBtn.isEnabled = false
    }
    
    

    
    
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        context = appDelegate.persistentContainer.viewContext
       
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)
        let newStudent = NSManagedObject(entity: entity!, insertInto: context)
        newStudent.setValue(nameTxtField.text ?? "", forKey: "name")
        newStudent.setValue(Int(ageTxtField.text ?? "0"), forKey: "age")
        newStudent.setValue(Int(studIdTxtField.text ?? "0"), forKey: "id")
        do{
            try context.save()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
           // fetchData()
        }catch{
            debugPrint("Can't save")
        }
        //fetchData()
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        //Here we will write some code, bear with me!
        guard nameTxtField.hasText && ageTxtField.hasText && studIdTxtField.hasText else{
            
            print("Text Fields are not validated, disable everything! ❌")
            registerBtn.isEnabled = false
            return
        }
       
        
        print("Text Fields are validated, enable everything! ✅")
        registerBtn.isEnabled = true
        
    }
    
    func setupTextFields() {
        studIdTxtField.addTarget(self,
                        action: #selector(self.textFieldDidChange(_:)),
                        for: UIControl.Event.editingChanged)
        ageTxtField.addTarget(self,
                        action: #selector(self.textFieldDidChange(_:)),
                        for: UIControl.Event.editingChanged)
        nameTxtField.addTarget(self,
                        action: #selector(self.textFieldDidChange(_:)),
                        for: UIControl.Event.editingChanged)
      
    }
    
    
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            print("Action")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension ViewController: UITextViewDelegate{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
}

extension UITextField {
    func isValid(with word: String) -> Bool {
        guard let text = self.text,
              !text.isEmpty else {
            print("Please fill the field.")
            return false
        }

        guard text.contains(word) else {
            print("Wrong word. Please check again.")
            return false
        }

        return true
    }
}


