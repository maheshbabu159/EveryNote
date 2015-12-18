//
//  FirstViewController.swift
//  SwiftCoreDataSimpleDemo
//
//  Created by maheshbabu.somineni on 12/10/15.
//  Copyright © 2015 CHENHAO. All rights reserved.
//

import UIKit
import CoreData
import EventKit

enum SegmentEnum: Int{
    
    case All = 0
    case Selected = 1
}
class NotesTableViewController: BaseViewController {

    let appDelegate:AppDelegate! = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var tasksTableView:UITableView!
    @IBOutlet var noteTextFiled:UITextField!

    var notesListArray:NSArray!
    var segmentSelectedIndex = 0
    
    //MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.notesListArray = NSArray()
        
        //super.showMenuButton()
        super.setViewBackGround(self.view)
        self.tasksTableView.backgroundColor = UIColor.clearColor()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
        tap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tap)
        
        
        self.refreshView()
        
        //let parameters = ["method":GlobalVariables.RequestAPIMethods.getComments.rawValue,"movieId":"lQl9OfB40U"]
        //super.showProgress()
        //NetworkManager.postRequest(parameters, delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dismissKeyboard(sender:AnyObject){
        
        if(self.noteTextFiled.text != ""){
            
            self.addNewNote()
            
        }
        self.noteTextFiled.text = ""
        self.noteTextFiled.resignFirstResponder()
        
        //Refresh the view
        self.refreshView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
 
    //MARK: Button click methods
    @IBAction func addButtonClick(sender:AnyObject){
        
        if(self.noteTextFiled.text != ""){
            
            self.addNewNote()
            self.refreshView()
            self.noteTextFiled.text = ""
            
        }
        
    }
    @IBAction func removeButtonClick(sender:AnyObject){
        
        if(self.segmentSelectedIndex == SegmentEnum.All.rawValue){
            
            let refreshAlert = UIAlertController(title: GlobalVariables.appName, message:"Are you sure want to delete all notes?" as String, preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                
                //Remove all objects
                NotesModel.truncateAllObjects(self.appDelegate.managedObjectContext)
                self.refreshView()
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
               
                
            }))

            self.presentViewController(refreshAlert, animated: true, completion: nil)
            
        }else{
            
            
            
        }
    }
    @IBAction func settingsButtonClick(sender:AnyObject){
        
        
        
        
    }
    @IBAction func editButtonClick(sender:AnyObject){
        
        

    }
    @IBAction func alarmButtonClick(sender:AnyObject){
        
        
        let button:UIButton = sender as! UIButton
        let indexPath = self.tasksTableView.indexPathForRowAtPoint(button.bounds.origin)
        
        let object:NotesModel = self.notesListArray.objectAtIndex(indexPath!.row) as! NotesModel
        
        
    }
    @IBAction func checkboxButtonClick(sender:AnyObject){
        
        
        
    }
    @IBAction func cancelButtonClick(sender:AnyObject){
        
        self.noteTextFiled.text = ""
        self.noteTextFiled.resignFirstResponder()
    }
    @IBAction func segmentValueChanged(sender:AnyObject){
        
        let segmentControll:UISegmentedControl = sender as! UISegmentedControl
        self.segmentSelectedIndex = segmentControll.selectedSegmentIndex
        self.refreshView()
        
    }
    //MARK: Eventstore methods
    func refreshView(){
        
        self.notesListArray = NotesModel.fetchAllObjects(self.appDelegate.managedObjectContext)
        self.tasksTableView.reloadData()
    }
    
    func addNewNote(){
       
        //Move to database
        let note:NSDictionary = ["title":GlobalVariables.appName ,"note":self.noteTextFiled.text!]
        
        NotesModel.insertObject(note as AnyObject, context: self.appDelegate.managedObjectContext)
        NotificationsHandler.addNotification(note as AnyObject)
    
    }
    
    //MARK:Service data handler
    override func dataDelegate(reponseData: AnyObject, requestMethod:GlobalVariables.RequestAPIMethods) {
        super.dataDelegate(reponseData, requestMethod: requestMethod)
        
        switch requestMethod{
            
        case .getComments:
            
            if let rootDictionary = reponseData as? [String:AnyObject]{
            
                if let resultArray:[AnyObject] = rootDictionary["result"] as? [AnyObject]{
                    
                    //Remove all objects
                    CommentsModel.truncateAllObjects(self.appDelegate.managedObjectContext)
                    
                    //Insert all records
                    for dictionary in resultArray{
                        
                        CommentsModel.insertObject(dictionary, context: self.appDelegate.managedObjectContext)
                        
                    }
                    
                    //Show the result count
                    let array:NSArray = CommentsModel.fetchAllObjects(self.appDelegate.managedObjectContext)
                    print(array.count)
                }
            }
            break
    
        default:
            print("")
        }
    }

}
extension NotesTableViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.notesListArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Cell creation
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
  
        //Set the values
        let object:NotesModel = self.notesListArray.objectAtIndex(indexPath.row) as! NotesModel
        
        //let alarmButton:UIButton = cell.contentView.viewWithTag(1000) as! UIButton
        let noteBodyLable:UILabel = cell.contentView.viewWithTag(1001) as! UILabel
        let editButton:UIButton = cell.contentView.viewWithTag(1002) as! UIButton
        let checkboxButton:UIButton = cell.contentView.viewWithTag(1003) as! UIButton

        
        if(self.segmentSelectedIndex == SegmentEnum.All.rawValue){
            
            editButton.hidden = true
            checkboxButton.hidden = true
            
            
        }else{
            
            editButton.hidden = false
            checkboxButton.hidden = false
            
        }
        
        //Set the values
        noteBodyLable.text = object.note! as String
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let object:NotesModel = self.notesListArray.objectAtIndex(indexPath.row) as! NotesModel
        GlobalSettings.showAlertView(GlobalVariables.appName, alertMsg: object.note!, target: self)
    }
    
}
extension NotesTableViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(self.noteTextFiled.text != ""){
            
            self.addNewNote()

        }
        self.noteTextFiled.text = ""
        self.noteTextFiled.resignFirstResponder()
        
        //Refresh the view
        self.refreshView()

        return true
    }
    
}
