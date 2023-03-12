import UIKit

var greeting = "Hello, playground"
//let number : Double = 13.7
//let numberDouble : Double = 12
//
//numberDouble
//number
//
//number + numberDouble
//
//let convertNumberString = String(number)
//let convertDoubleToInt = Int(number)
//
//let rounded = number.rounded(.up)

// robimy zadania

//Zadeklaruj stałą lub zmienną typu Int i przypisz do niej wartość liczbową.
let numberInt : Int = 18
//Zadeklaruj stałą lub zmienną typu Double i przypisz do niej wartość liczbową zmiennoprzecinkową.
let numberDouble : Double = 18.5
//Zadeklaruj dwie zmienne typu Int i wykonaj na nich operację dodawania.
let int1 : Int = 43
let int2 : Int = 45
int1 + int2
//Zadeklaruj dwie zmienne typu Double i wykonaj na nich operację mnożenia.
let double1 : Double = 25.7
let double2 : Double = 213.344
double1 * double2
//Zadeklaruj stałą lub zmienną typu Int i sprawdź, czy jest parzysta.
let orEven : Int = 3

if orEven % 2 == 0{
    true
} else{
    false
}

func checkIsEven(numberCos : Int) -> Bool{
    if numberCos % 2 == 0{
        return true
    } else {
        return false
    }
}

checkIsEven(numberCos: 31)

//Zadeklaruj stałą lub zmienną typu Double i sprawdź, czy jest dodatnia.
let numberPlus : Int = 20

func checkIfPlus(number : Int) -> Bool{
    if number > 0{
        return true
    } else {
        return false
    }
}

checkIfPlus(number: 20)
checkIfPlus(number: -23)
//Zadeklaruj stałą lub zmienną typu Int i sprawdź, czy jest mniejsza niż 10.
let ifThenTen : Int = 11

func check(number: Int) -> Bool{
    return number > 10
}
//Zadeklaruj dwie zmienne typu Double i porównaj je, aby sprawdzić, czy są równe.
let intA : Int = 10
let intB : Int = 10

func checkEquals(numberA: Int, numberB: Int) -> Bool{
    if numberA == numberB{
        return true
    } else {
        return false
    }
}

checkEquals(numberA: intA, numberB: intB)

//Zadeklaruj dwie zmienne typu Int i wykonaj na nich operację modulo (%), aby sprawdzić, czy jedna liczba jest podzielna przez drugą.

let modulo1: Int = 20
let modulo2: Int = 12

func modulo(number1: Int, number2: Int) -> Bool {
    if number1 % number2 == 0 {
        return true
    } else {
        return false
    }
}

modulo(number1: 20, number2: 34)
//Zadeklaruj stałą lub zmienną typu Double i zaokrąglij ją do najbliższej liczby całkowitej.

let numberToUp : Double = 3.234

numberToUp.rounded(.up)
