//
//  BaseViewController.swift
//  SwiftCoreDataSimpleDemo
//
//  Created by maheshbabu.somineni on 12/10/15.
//  Copyright © 2015 CHENHAO. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol MenuButtonDelegate {
    
    func toggleLeftPanel()
    func collapseSidePanels()
}

class BaseViewController: UIViewController, CMNetworkDelegate {
    
    var menuButtonDlegate: MenuButtonDelegate?
    var progressHUD = MBProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()

     
        GlobalSettings.increaseAppIterationNumber()
    }
    func setViewBackGround(view:UIView){
        
        // Do any additional setup after loading the view.
        let backImage = UIImage(named: "main_background")
        let resizablebackImage = backImage?.resizableImageWithCapInsets(UIEdgeInsets(top:10,left:0,bottom:10,right:0))
        view.backgroundColor = UIColor(patternImage:resizablebackImage!)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProgress(){
       
        //Show the progress bard
        progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK:Menu button delegate methods
    func showMenuButton(){
     
        let menuButton : UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: "menuButtonClick")
        menuButton.image = UIImage(named: "menu_button")
        self.navigationItem.leftBarButtonItem = menuButton
    }
    func menuButtonClick() {
        
        super.view.endEditing(true)
        self.menuButtonDlegate!.toggleLeftPanel()
        
    }
    //MARK:Service delegate methods
    func dataDelegate(reponseData:AnyObject, requestMethod:GlobalVariables.RequestAPIMethods){
        
        progressHUD.hide(true)
        print("\(requestMethod) = \(reponseData)")
    }
    func networkError(errorMessage:String){
        
        progressHUD.hide(true)
        GlobalSettings.showAlertView(GlobalVariables.appName, alertMsg: errorMessage, target: self)
    }


}
