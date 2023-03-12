import Foundation

//Napisz funkcję, która będzie zwracała liczbę wystąpień podanego słowa w tekście.

let loremIpsum : String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras vitae ante est. Phasellus placerat lectus sit amet velit porttitor, ac hendrerit eros molestie. SIT Sit sIT"

let word : String = "sit".uppercased()

func searchWord(text: String, word: String) -> Int{
    let countWord = text.components(separatedBy: " ").filter{ $0 == word}.count
    return countWord
}

searchWord(text: loremIpsum, word: word)


//Napisz funkcję, która będzie zwracała sumę liczb z podanej tablicy.

var numbers = [Int]()

func additionArray() -> [Int]{
    
    for _ in 0..<100{
        let randomInt = Int.random(in: 1...1000)
        numbers.append(randomInt)
    }
    return numbers
}
numbers = additionArray()
print(numbers)
//Napisz funkcję, która będzie zwracała różnicę między dwoma liczbami całkowitymi.
func subtraction(numberA:Int, numberB: Int) -> Int{
    return numberA - numberB
}

subtraction(numberA: 43, numberB: 1980)

//Napisz funkcję, która będzie zwracała średnią arytmetyczną z podanych liczb.

func mean(numbers: [Int]) -> Double{
    let sum = numbers.reduce(0, +)
    let count = numbers.count
    return Double(sum / count)
}

let avg = mean(numbers: numbers)

//Napisz funkcję, która będzie zwracała największą liczbę z podanej tablicy.

let arrayNumber : Array = [12,212,12,12,11,45,675]

func highNumber(array: Array<Int>) -> Int?{
    return array.max()
}
highNumber(array: arrayNumber)

//Napisz funkcję, która będzie zwracała najmniejszą liczbę z podanej tablicy.

func lowerNumber(array: Array<Int>) -> Int?{
    return array.min()
}
lowerNumber(array: arrayNumber)
//Napisz funkcję, która będzie zwracała łańcuch znaków z odwróconym porządkiem liter.

let characterSet : Array<Character> = ["a","d","v","b","d","f","w","q","w","e","f","f","f"]

func characterReturn(array: Array<Character>) -> String {
    let uniqueCharacters = Array(Set(array))
    return String(uniqueCharacters.sorted())
}
characterReturn(array: characterSet)

//Napisz funkcję, która będzie zwracała sumę kwadratów liczb z podanej tablicy.


//Napisz funkcję, która będzie zwracała łańcuch znaków bez spacji.

func removeSpaces(string: String) -> String{
    let symbol : String = " "
    return string.replacingOccurrences(of: symbol, with: "")
}
removeSpaces(string: loremIpsum)

//Napisz funkcję, która będzie zwracała łańcuch znaków z pierwszą literą każdego wyrazu zamienioną na wielką literę.

func convertToUppercaseFirstLetter(string: String) -> String{
   return string.capitalized
}

convertToUppercaseFirstLetter(string: loremIpsum)


