//
//  dateFormatter.swift
//  rebe2CoreData
//
//  Created by Łukasz Muszyński on 10/03/2023.
//

import Foundation


func convertDate(date: Date) -> String{
        let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
            return formatter
        }()
    let convertDateString = dateFormatter.string(from: date)
    return convertDateString
}

func monthFormatter(date: Date) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM"
    return formatter.string(from: date)
    
}

func dayFormatter(date: Date) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "d"
    return formatter.string(from: date)
    
}
