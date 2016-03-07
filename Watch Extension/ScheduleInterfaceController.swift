//
//  ScheduleInterfaceController.swift
//  AirAber
//
//  Created by chengxianghe on 16/2/21.
//  Copyright © 2016年 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {

    @IBOutlet var flightsTable: WKInterfaceTable!
    var selectedIndex = 0

    var flights = Flight.allFlights()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
        
        for index in 0..<flightsTable.numberOfRows {

            if let controller = flightsTable.rowControllerAtIndex(index) as? FlightRowContorller {
                controller.flight = flights[index]
            }
        }


    }
    
    
    override func didAppear() {
        super.didAppear()
        // 1
        if flights[selectedIndex].checkedIn, let controller = flightsTable.rowControllerAtIndex(selectedIndex) as? FlightRowContorller {
            // 2
            animateWithDuration(0.35, animations: { () -> Void in
                // 3
                controller.updateForCheckIn()
            })
        }
    }

    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let flight = flights[rowIndex]
        let controllers = flight.checkedIn ? ["Flight", "BoardingPass"] : ["Flight", "CheckIn"]
        presentControllerWithNames(controllers, contexts:[flight, flight])
        selectedIndex = rowIndex

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
