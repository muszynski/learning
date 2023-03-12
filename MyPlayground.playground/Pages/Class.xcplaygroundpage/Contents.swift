import Foundation

//Utwórz klasę Person, która będzie przechowywać imię i nazwisko osoby.

class Person{
    var name : String = ""
    var lastName : String = ""
    
    init(name: String, lastName: String){
        self.name = name
        self.lastName = lastName
    }
}
let person = Person(name: "Jan", lastName: "Kowalski")

//Utwórz klasę Rectangle, która będzie przechowywać długość i szerokość prostokąta.

class Rectangle{
    var width : Double
    var height : Double
    
    init(width: Double, height: Double){
        self.width = width
        self.height = height
    }
}

let rectangle = Rectangle(width: 12, height: 23)
//Utwórz klasę Vehicle, która będzie przechowywać markę i model pojazdu.

class Vehicle{
    var brand : String
    var model : String
    
    init(brand: String, model: String){
        self.brand = brand
        self.model = model
    }
}
//Utwórz klasę Employee, która będzie przechowywać imię, nazwisko i stanowisko pracownika.

class Employee{
    var name : String
    var lastName : String
    var stanowisko : String
    
    init(name: String, lastName: String, stanowisko: String){
        self.name = name
        self.lastName = lastName
        self.stanowisko = stanowisko
    }
}

//Utwórz klasę BankAccount, która będzie przechowywać numer konta, nazwisko właściciela oraz saldo.

class BankAccount{
    var lastName : String
    var accountNumber : String
    
    init(lastName: String, accountNumber: String){
        self.lastName = lastName
        self.accountNumber = accountNumber
    }
}

//Utwórz klasę Point, która będzie przechowywać współrzędne punktu na płaszczyźnie.
class Point{
    var positionX : Double
    var positionY : Double
    
    init(positionX : Double, positionY: Double){
        self.positionX = positionX
        self.positionY = positionY
    }
}


//Utwórz klasę Car, która będzie dziedziczyć po klasie Vehicle i dodawać pola dotyczące koloru i liczby drzwi.

class Car: Vehicle {
    init(color : String, door: Int, brand: String, model: String){
        super.init(brand: brand, model: model)
        self.brand = brand
        self.model = model
    }
}

//Utwórz klasę Animal, która będzie przechowywać imię zwierzęcia i jego gatunek.
class Animal{
    var name : String
    var species : String
    
    init(name: String, species: String){
        self.name = name
        self.species = species
    }
}

//Utwórz klasę Book, która będzie przechowywać tytuł, autora i datę wydania książki.

class Book{
    var title : String
    var author : String
    var datePublishing : Date
    
    init(title: String, author: String, datePublishing: Date){
        self.title = title
        self.author = author
        self.datePublishing = datePublishing
    }
}

//Utwórz klasę MusicAlbum, która będzie przechowywać tytuł albumu, wykonawcę i listę utworów.

class MusicAlbum{
    var title : String
    var author: String
    var song : Array<String>
    
    init(title: String, author: String, song: Array<String>){
        self.title = title
        self.author = author
        self.song = song
    }
}
