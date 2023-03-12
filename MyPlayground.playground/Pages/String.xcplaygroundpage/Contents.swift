//: [Previous](@previous)

import Foundation


//Zadeklaruj stałą lub zmienną typu String i przypisz do niej wartość tekstu.

let simpeleText : String = "Mam na imię Łukasz"

//Zadeklaruj stałą lub zmienną typu String i wykorzystaj interpolację łańcuchów, aby wstawić wartość zmiennej do tekstu.

let textToInsert : String = "Sir"

let interpolationString : String = "Zwracj się do mnie \(textToInsert) Łukasz"

//Zadeklaruj stałą lub zmienną typu String i wykorzystaj operator konkatenacji (+), aby połączyć dwa łańcuchy znaków.

let contact : String = "Dzień" + " " + "Dobry"

//Zadeklaruj stałą lub zmienną typu String i wykonaj na niej operację count, aby sprawdzić długość tekstu.

let longText : String = "Jakiś bardzo dłiugi tekst który policzymy"
longText.count

//Zadeklaruj stałą lub zmienną typu String i wykorzystaj metodę isEmpty, aby sprawdzić, czy tekst jest pusty.

let checkIsEmpty : String = "Tekst do sprawdzenia"
checkIsEmpty.isEmpty

//Zadeklaruj stałą lub zmienną typu String i wykorzystaj metodę lowercased, aby zmienić wszystkie litery w tekście na małe.

let toUpper : String = "DUZE LITERYi"
toUpper.lowercased()
//Zadeklaruj stałą lub zmienną typu String i wykorzystaj metodę uppercased, aby zmienić wszystkie litery w tekście na duże.

let toLower : String = "tekst malymi literami"
toLower.uppercased()
//Zadeklaruj stałą lub zmienną typu String i wykorzystaj metodę replacingOccurrences, aby zamienić jedno wystąpienie określonej frazy na inną.
let changeText : String = "W tym ciągu znaków zamienimy Biały na Rudy"
changeText.replacingOccurrences(of: "Biały", with: "Kolor")

//Zadeklaruj stałą lub zmienną typu String i wykorzystaj metodę split(separator:), aby podzielić tekst na tablicę podłańcuchów na podstawie określonego separatora.

let convertTextToArray = "Czerowny, Rudy, Biały, Szary, Zielony"
convertTextToArray.split(separator: ",")

//Zadeklaruj stałą lub zmienną typu String i wykorzystaj metodę trimmingCharacters(in:), aby usunąć określone znaki z początku i końca tekstu.
let trimCharacter : String = "Długi teskt do skrócenia"
trimCharacter.trimmingCharacters(in: .whitespaces)
let characeterSetIn = CharacterSet(charactersIn: "Długi")
trimCharacter.trimmingCharacters(in: characeterSetIn)

//let characterSetOut = CharacterSet(charactersIn: "skrócenia").dropLast()
