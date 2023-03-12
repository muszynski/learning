import Foundation


//Oto 10 zadań, które wymagają napisania prostych funkcji, operujących na liczbach i stringach w języku Swift:
//
//Napisz funkcję, która będzie zwracała liczbę znaków w podanym ciągu znaków.

func characterCount(string: String) -> Int{
    return string.count
    
}
characterCount(string: "Dzisiaj pada deszcz")
let sampleText = "Dzisiaj na obiad będzie tajskie jedzenie"
characterCount(string: sampleText)
let sampletextShort = "Rudzik"
characterCount(string: sampletextShort)

//Napisz funkcję, która będzie zwracała sumę dwóch liczb całkowitych.

func sumInt(numberA: Int, numberB: Int) -> Int{
    numberA + numberB
}
sumInt(numberA: 50, numberB: 20)

//Napisz funkcję, która będzie zwracała wynik mnożenia dwóch liczb całkowitych.
func multiplication(numberA: Int, numberB: Int) -> Int{
    numberA * numberB
}
multiplication(numberA: 3, numberB: 4)
multiplication(numberA: 2, numberB: 2)

//Napisz funkcję, która będzie zwracała wartość bezwzględną z podanej liczby całkowitej.
func absoluteValue(number: Int) -> Int{
    if number >= 0{
        return number
    } else{
        return number * -1
    }
}
absoluteValue(number: -234)

//Napisz funkcję, która będzie zwracała wartość podanej liczby całkowitej w postaci łańcucha znaków.
func convertIntToString(number: Int) -> String{
    String(number)
}
convertIntToString(number: 23443)

//Napisz funkcję, która będzie zwracała długość najdłuższego wyrazu w podanym ciągu znaków.

let loreimIpsum : String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nibh eros"

func longWord(text: String) -> Int{
    var longestWord : String = ""
    var arrayFromText = text.components(separatedBy: " ")
    for arrayFromtextWords in arrayFromText{
        if arrayFromText.count > longestWord.count{
            longestWord = arrayFromtextWords
        }
    }
    return longestWord.count
}

longWord(text: loreimIpsum)

//Napisz funkcję, która będzie zwracała liczbę wystąpień określonego znaku w podanym ciągu znaków.
func countCharacter(text: String, character : Character) -> Int{
    return text.filter{$0 == character}.count
}

countCharacter(text: loreimIpsum, character: "s")
//Napisz funkcję, która będzie zwracała łańcuch znaków z literami posortowanymi w kolejności alfabetycznej.

func sortCharacterString(text: String) -> String{
    let characterArray = Array(text)
    return String(characterArray.sorted())
}

sortCharacterString(text: loreimIpsum)

//Napisz funkcję, która będzie zwracała łańcuch znaków bez określonych znaków specjalnych.

func removeSpecialSing(text: String) -> String{
    let characterRemove : String = "."
    return text.replacingOccurrences(of: characterRemove, with: "")
}

removeSpecialSing(text: loreimIpsum)

//Napisz funkcję, która będzie zwracała łańcuch znaków z zamienionymi miejscami literami w podanym ciągu znaków. Na przykład, "Hello, World!" powinno zostać zamienione na "hELLO, wORLD!".
//
//func convertCharacter(text: String) -> String{
//    let arrayFromString : Array(text)
//}
