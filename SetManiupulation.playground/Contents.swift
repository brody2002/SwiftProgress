import UIKit


import UIKit

var swiftUIDevs: Set = ["Sean", "James"]
var swiftDevs: Set = ["Sean", "James", "Olivia", "Maya", "Leo"]
var kotlinDevs: Set = ["Olivia", "Elijah", "Leo", "Maya", "Dan"]
var experiencedDevs: Set = ["Sean", "Ava", "Olivia", "Leo"]

// Intersect - pull out overlap
let experiencedSwiftUIDevs = swiftUIDevs.intersection(experiencedDevs)
print("intersection example: \(experiencedSwiftUIDevs)\n")

// Subtract - pull out difference
let jrSwiftDev = swiftDevs.subtracting(experiencedDevs)
print("subtract example: \(jrSwiftDev)\n")

// Disjoint - check for overlap
// false -> overlap
// true -> no overlap
let disjointExample = swiftUIDevs.isDisjoint(with: swiftDevs)
print("disjoin example: \(disjointExample)\n")

// Union -> combined
let unionExample = swiftDevs.union(swiftDevs)
print("unionExample: \(unionExample)\n")


// Exclusive to only one group or set
let specialists = swiftDevs.symmetricDifference(kotlinDevs)
print("symmetricDifference Example: \(specialists)")


// Subset
swiftUIDevs.isSubset(of: kotlinDevs)

// Superset
swiftDevs.isSuperset(of: swiftUIDevs)

// Insert, Delete, Find
swiftDevs.insert("Joe")
swiftDevs.remove("Sean")
swiftDevs.contains("Maya")
swiftDevs
