//
//  MenuCell.swift
//  Percentages
//
//  Created by Thomas Andre Johansen on 21/01/16.
//  Copyright © 2016 Appkokeriet. All rights reserved.
//

import UIKit
import Foundation


//this needs to subclass UITableViewCell so I can assign all the cells in the tableview to be this
//then i can pass a cell to the next view and get all its info like titleLabel etc from this.

class MenuCell: UITableViewCell{
    
    var labelTitle = NSLocalizedString("DEFAULT_LABEL_TITLE", comment:"defaultLabelTitle")
    var labelNumberOne = NSLocalizedString("DEFAULT_LABEL_NUMBER_ONE", comment:"defaultLabelNumberOne")
    var labelNumberTwo = NSLocalizedString("DEFAULT_LABEL_NUMBER_TWO", comment:"defaultLabelNumberTwo")
    var labelResult = NSLocalizedString("DEFAULT_LABEL_RESULT", comment:"defaultLabelResult")
    var percent = false
    var calculateFunction = NSLocalizedString("DEFAULT_CALCULATE_FUNCTION", comment:"defaultCalculateFunction")
    
    
    
    func createCell(_ section: Int, row: Int, cell: MenuCell) -> MenuCell{
        switch(section){
        //Discount
        case 0:
            switch(row){
            case 0:
                cell.labelTitle = NSLocalizedString("CELL_0_0_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CELL_0_0_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CELL_0_0_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CELL_0_0_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "calculateNewPrice"
                cell.percent = true
                cell.textLabel!.text = cell.labelTitle
            case 1:
                cell.labelTitle = NSLocalizedString("CELL_0_1_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CELL_0_1_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CELL_0_1_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CELL_0_1_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "calculateDiscount"
                cell.percent = false
                cell.textLabel!.text = cell.labelTitle
            default:
                cell.textLabel!.text = "Something went wrong. :("
            }
        //percent
        case 1:
            switch(row){
            case 0:
                cell.labelTitle = NSLocalizedString("CELL_1_0_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CELL_1_0_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CELL_1_0_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CELL_1_0_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "findPercent"
                cell.percent = false
                cell.textLabel!.text = cell.labelTitle
            case 1:
                cell.labelTitle = NSLocalizedString("CELL_1_1_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CELL_1_1_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CELL_1_1_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CELL_1_1_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "findPercentValue"
                cell.percent = true
                cell.textLabel!.text = cell.labelTitle
            case 2:
                cell.labelTitle = NSLocalizedString("CELL_1_2_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CELL_1_2_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CELL_1_2_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CELL_1_2_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "addPercent"
                cell.percent = false
                cell.textLabel!.text = cell.labelTitle
                
            default:
                cell.textLabel!.text = "Something went wrong. :("
            }
        //TAX
        case 2:
            switch(row){
            case 0:
                cell.labelTitle = NSLocalizedString("CELL_2_0_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CELL_2_0_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CELL_2_0_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CELL_2_0_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "addTax"
                cell.percent = true
                cell.textLabel!.text = cell.labelTitle
            case 1:
                cell.labelTitle = NSLocalizedString("CELL_2_1_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CELL_2_1_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CELL_2_1_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CELL_2_1_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "removeTax"
                cell.percent = true
                cell.textLabel!.text = cell.labelTitle
            default:
                cell.textLabel!.text = "Something went wrong. :("
            }
        //BREAK-EVEN ANALYSIS
        case 3:
            switch(row){
            case 0:
                cell.labelTitle = NSLocalizedString("CONTRIBUTION_MARGIN_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CONTRIBUTION_MARGIN_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CONTRIBUTION_MARGIN_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CONTRIBUTION_MARGIN_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "contributionMargin"
                cell.percent = false
                cell.textLabel!.text = cell.labelTitle
            case 1:
                cell.labelTitle = NSLocalizedString("CONTRIBUTION_MARGIN_RATIO_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CONTRIBUTION_MARGIN_RATIO_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CONTRIBUTION_MARGIN_RATIO_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CONTRIBUTION_MARGIN_RATIO_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "contributionMarginRatio"
                cell.percent = true
                cell.textLabel!.text = cell.labelTitle
            default:
                cell.textLabel!.text = "Something went wrong:("
            }
        //GRATUITY
        case 4:
            switch(row){
            case 0:
                cell.labelTitle = NSLocalizedString("CELL_3_0_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CELL_3_0_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CELL_3_0_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CELL_3_0_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "calculateTip"
                cell.percent = true
                cell.textLabel!.text = cell.labelTitle
            case 1:
                cell.labelTitle = NSLocalizedString("CELL_3_1_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CELL_3_1_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CELL_3_1_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CELL_3_1_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "calculateTipReceived"
                cell.percent = false
                cell.textLabel!.text = cell.labelTitle
            default:
                cell.textLabel!.text = "Something went wrong. :("
            }
        //ABOUT
        case 5:
            switch(row){
            case 0:
                cell.labelTitle = NSLocalizedString("CELL_4_0_TITLE", comment: "Cell00Title")
                cell.labelNumberOne = NSLocalizedString("CELL_4_0_LABELONE", comment: "Cell00LabelOne")
                cell.labelNumberTwo = NSLocalizedString("CELL_4_0_LABELTWO", comment: "Cell00LabelTwo")
                cell.labelResult = NSLocalizedString("CELL_4_0_RESULT", comment: "Cell00Result")
                cell.calculateFunction = "about"
                cell.percent = false
                cell.textLabel!.text = cell.labelTitle
            default:
                cell.textLabel!.text = "Something went wrong. :("
            }
        default:
            print("gikk i default section.-switch")
        }
        return cell
    }
}
