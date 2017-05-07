//
//  MenuTableViewController.swift
//  Percentages
//
//  Created by Thomas Andre Johansen on 19/01/16.
//  Copyright © 2016 Appkokeriet. All rights reserved.
//

import UIKit

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footer: UIView!
    
    //setup table with sections and cells
    let numberOfRowsInSection = [2,3,2,2,2,1]
    let titleForHeaderInSection =
       [NSLocalizedString("DISCOUNT", comment: "discountHeader"),
        NSLocalizedString("RATIOS", comment:"ratiosHeader"),
        NSLocalizedString("SALES_TAX", comment:"salesTaxHeader"),
        NSLocalizedString("BREAK_EVEN_ANALYSIS", comment: "breakEvenAnalysis"),
        NSLocalizedString("GRATUITY", comment:"gratuityHeader"),
        NSLocalizedString("ABOUT", comment:"aboutHeader")]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //appearance of view
        self.view.backgroundColor = UIColor.white
        self.title = NSLocalizedString("MENU_TITLE_TEXT", comment:"")
        self.automaticallyAdjustsScrollViewInsets = false
        
        //appearance of tableView
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView()
    
        //appearance of navigationcontroller
        //self.navigationController?.navigationBar.barStyle = .Default
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.blue
        self.navigationController?.navigationBar.backgroundColor = UIColor.blue
        self.navigationController?.navigationBar.tintColor = UIColor.white        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        


        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //remove the selected row with fade out
    override func viewWillAppear(_ animated: Bool) {
        if let selectedRow : IndexPath = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: selectedRow, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        return titleForHeaderInSection.count
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection[section]
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleForHeaderInSection[section]
    }
    
    //appearance of section headers
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.white
        header.textLabel!.textColor = UIColor.black
        header.textLabel!.font = UIFont.boldSystemFont(ofSize: 23)
        //header.alpha = 0.5
    }


    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        //appearance of cell
        //gray cell.backgroundColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
        cell.backgroundColor = UIColor.white
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.81, green: 0.89, blue: 0.95, alpha: 1.0)
        cell.selectedBackgroundView = backgroundView
        _ = cell.createCell(indexPath.section, row: indexPath.row, cell: cell)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let newView = segue.destination as! CalculateViewController
        newView.passedCell = sender as! MenuCell
    }

}
