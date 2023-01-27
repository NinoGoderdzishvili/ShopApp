//
//  SequenceExtension.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/25/23.
//

import Foundation

//public extension Sequence {
//    func categorise<U : Hashable>(_ key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
//        var dict: [U:[Iterator.Element]] = [:]
//        for el in self {
//            let key = key(el)
//            if case nil = dict[key]?.append(el) { dict[key] = [el] }
//        }
//        return dict
//    }
//}

//public extension Sequence {
//    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
//        var categories: [U: [Iterator.Element]] = [:]
//        for element in self {
//            let key = key(element)
//            if case nil = categories[key]?.append(element) {
//                categories[key] = [element]
//            }
//        }
//        return categories
//    }
//}

extension Sequence {
    func group<GroupingType: Hashable>(by key: (Iterator.Element) -> GroupingType) -> [[Iterator.Element]] {
        var groups: [GroupingType: [Iterator.Element]] = [:]
        var groupsOrder: [GroupingType] = []
        forEach { element in
            let key = key(element)
            if case nil = groups[key]?.append(element) {
                groups[key] = [element]
                groupsOrder.append(key)
            }
        }
        
        return groupsOrder.map { groups[$0]! }
    }
}
