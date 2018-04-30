//
//  VerificatedViewController.swift
//  firebase7app
//
//  Created by mescurra on 4/29/18.
//  Copyright © 2018 mescurra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class VerificatedViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    
      let currentUser = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userAccess()
        self.accesFirebaseListener()
    }
    
    // MARK: - User
    func userAccess(){
        if (currentUser != nil) {
            userLabel.text = currentUser
        } else {
            userLabel.text = "No Usuario"
        }
    }
    
    // MARK: - Firebase Listener
    func accesFirebaseListener(){
        Auth.auth().addStateDidChangeListener( { (user, error) in
            if Auth.auth().currentUser != nil{
                print("Accedido en Verificated")
            } else {
                print("Inhabilitado en Verificated")
            }
        })
    }
    
    // MARK: - Firebase LogOut
    func logOutFirebase(){
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
        }
    }
    
    // MARK: - Button LogOut Firebase
    @IBAction func logOutButton(_ sender: UIButton) {
        self.logOutFirebase()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
