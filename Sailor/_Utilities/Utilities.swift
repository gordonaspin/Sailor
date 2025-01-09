//
//  Utilities.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/8/25.
//

func getOrientation(orientation: Int) -> String {
    switch orientation {
        case 1: return "po"
        case 2: return "ud"
        case 3: return "lr"
        case 4: return "ll"
        default: return "unk"
    }
}
