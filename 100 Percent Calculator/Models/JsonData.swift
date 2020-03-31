/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helpers for loading images and data.
*/

import UIKit
import SwiftUI

var calculationsData: [CalculationCategory] = load("CalculationsData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    let fileManager = FileManager.default
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("PersonalCalculationsData.json")
    if fileManager.fileExists(atPath: url.path){
        data = fileManager.contents(atPath: url.path)!
    }else {
        guard let defaultFile = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
                
        do {
            data = try Data(contentsOf: defaultFile)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

