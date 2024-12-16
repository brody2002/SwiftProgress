

import Foundation

// Reduce example
let numbersGiven = [1, 2, 3, 4, 5]
let reducedNumbers = numbersGiven.reduce(0 , {$0 + $1})
//print(reducedNumbers)

// Map Example

let mapNumbers = [1, 3, 5, 7]
let mapNumbersApplied = mapNumbers.map {$0 * 33}
//print(mapNumbersApplied)

// Compact Map

let nilNumbers = [1, nil, 3, nil, 5]
let nonNilNumbers = nilNumbers.compactMap {$0}
//print(nonNilNumbers)

// Filter Examples
struct Animal {
    var amount: Int
    var name: String
}

var animalList: [Animal] = [Animal(amount: 33, name: "Pyrax"), Animal(amount: 2, name: "Doggo")]
let filteredAnimals = animalList.filter{ $0.amount > 3}
//print("filteredAnimals \(filteredAnimals)")


// Flat Map Example

let nestedArray = [[5, 5, 5],[5, 5, 5]]
let flattenedArray = nestedArray.flatMap { $0 }
print(flattenedArray)

    // contined...
let reducedFlattenedArray = flattenedArray.reduce(into: 1) { partialResult, value in
    return partialResult *= value
}
//print(reducedFlattenedArray)


