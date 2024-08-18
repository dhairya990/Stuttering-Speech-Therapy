//
//  newChart.swift
//  tryingCharts
//
//  Created by Sambhav Singh on 28/05/24.
//

import SwiftUI
import Charts
import Foundation

struct newchart : View {
    
  
    
    var body: some View {
        
        Chart(DataController.shared.wordCountPerDay) { day in
            let dayIndex = DataController.shared.wordCountPerDay.firstIndex(where: {$0.id == day.id})!
            
            BarMark(
                x: .value("Days", weekDays[dayIndex].rawValue),
                y: .value("Words", day.noStutterCount)
            ).annotation(position: .overlay){
                day.noStutterCount > 0 ?
                Text(String(day.noStutterCount)) : Text("")
            }
            .foregroundStyle(by: .value("Type", "No Stutter"))
            
            BarMark(
                x: .value("Days", weekDays[dayIndex].rawValue),
                y: .value("Words", day.stutterCount)
            ).annotation(position: .overlay){
                day.stutterCount > 0 ?
                Text(String(day.stutterCount)) : Text("")
            }
            .foregroundStyle(by: .value("Type", "Stutter"))
            
            
            RuleMark(y: .value("Average", 5)).foregroundStyle(.red)
        }
        .aspectRatio(1, contentMode: .fill)
        .padding()
        .background(Color(red: 229/255, green: 229/255, blue: 252/255))
        .cornerRadius(15)
        .shadow(radius: 5)
   
    }
}
