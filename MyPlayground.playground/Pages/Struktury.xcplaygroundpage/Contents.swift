import Foundation

//Utwórz strukturę Person, która będzie zawierała imię, nazwisko i wiek danej osoby. Następnie utwórz kilka instancji tej struktury i wyświetl ich właściwości na konsoli.
//

struct Person{
    var name : String
    var lastName : String
    var age : Int
}

var person1 = Person(name : "Lukasz", lastName : "Muszynski", age : 23)
var person2 = Person(name : "Aneta", lastName : "Muszynska", age : 32)
print(person1.name)
print(person1.lastName)
print(person1.age)

print(person2.name)
print(person2.lastName)
print(person2.age)

//Utwórz strukturę Rectangle, która będzie zawierała długość i szerokość prostokąta. Następnie napisz funkcję, która obliczy pole powierzchni prostokąta na podstawie tych wartości.
//

struct Rectangle{
    var width : Double
    var height : Double
}

var rectangle1 = Rectangle(width: 23, height: 456)
var rectangle2 = Rectangle(width: 22, height: 33)

func rectangleSquare(width: Double, height: Double) -> Double{
    return width * height
}

rectangleSquare(width: rectangle1.width, height: rectangle1.height)
rectangleSquare(width: rectangle2.width, height: rectangle2.height)

//Utwórz strukturę Book, która będzie zawierała tytuł, autora i rok wydania książki. Następnie utwórz kilka instancji tej struktury i wyświetl ich właściwości na konsoli.
//

struct Book{
    var title: String
    var author: String
    var year: Int
}

var book1 = Book(title: "tytuł 1", author: "Ja", year: 1222)
print("to jest ksiazka 1 \(book1.title) \(book1.author) \(book1.year)")

//Utwórz strukturę Point, która będzie zawierała współrzędne punktu na płaszczyźnie. Następnie napisz funkcję, która obliczy odległość między dwoma punktami na podstawie ich współrzędnych.
//

struct Point{
    var positionX: Int
    var positionY: Int
}

var pointA = Point(positionX: 10, positionY: 12)
var pointB = Point(positionX: 23, positionY: 44)

//FIXME: dopisz funkcje

//Utwórz strukturę Temperature, która będzie zawierała temperaturę w stopniach Celsiusza. Następnie napisz funkcję, która przeliczy tę temperaturę na stopnie Fahrenheita.
//

struct Temperature{
    var tempF: Double
}

var temp1 = Temperature(tempF: 12)
var temp2 = Temperature(tempF: 435)

func convertToC(F: Double) -> Double{
    let celsius = (F - 32.0) * 5.0 / 9.0
    return celsius
}

convertToC(F: temp1.tempF)
convertToC(F: temp2.tempF)

//Utwórz strukturę Car, która będzie zawierała markę, model i rok produkcji samochodu. Następnie utwórz kilka instancji tej struktury i wyświetl ich właściwości na konsoli.
//

struct Car{
    var marka : String
    var model : String
    var rokProdukcji : Int
}

var car1 = Car(marka: "mazda", model: "CX3", rokProdukcji: 2020)
var moto1 = Car(marka: "ducati", model: "Streetfighter", rokProdukcji: 2022)

print("marka: \(car1.marka) model: \(car1.model) rok: \(car1.rokProdukcji)")
print("marka: \(moto1.marka) model: \(moto1.model) rok: \(moto1.rokProdukcji)")
      

//Utwórz strukturę Circle, która będzie zawierała promień koła. Następnie napisz funkcję, która obliczy pole powierzchni koła na podstawie tego promienia.
//

struct Circle{
    var r : Double
}

func circleRound(r: Double) -> Double{
    return r * 3.14
}

var circle1 = Circle(r: 12)
var circle2 = Circle(r: 23)
var circle3 = Circle(r: 45)

circleRound(r: circle1.r)
circleRound(r: circle2.r)
circleRound(r: circle3.r)

//Utwórz strukturę Movie, która będzie zawierała tytuł, reżysera i rok produkcji filmu. Następnie utwórz kilka instancji tej struktury i wyświetl ich właściwości na konsoli.
//

struct Movie{
    var title: String
    var director : String
    var year : Int
}

var movie1 = Movie(title: "Jak pokochałem Anete", director: "Życie", year: 2015)
var movie2 = Movie(title: "Demony Wojny", director: "Kosowo", year: 2000)

print("film: \(movie1.title) rezyser: \(movie1.director) rok: \(movie1.year)")
print("film: \(movie2.title) rezyser: \(movie2.director) rok: \(movie2.year)")

//Utwórz strukturę Employee, która będzie zawierała imię, nazwisko, stanowisko i wynagrodzenie pracownika. Następnie utwórz kilka instancji tej struktury i wyświetl ich właściwości na konsoli.
//

struct Employee{
    var name: String
    var lastName: String
    var stanowisko: String
    var kasa : Double
}

var pracownik1 = Employee(name: "Lukasz", lastName: "Kot", stanowisko: "Kierownik", kasa: 123)

print("imie: \(pracownik1.name) nazwisko: \(pracownik1.lastName), stanowisko: \(pracownik1.stanowisko) kasa: /(pracownik1.kasa)")

//Utwórz strukturę Product, która będzie zawierała nazwę, opis i cenę produktu. Następnie utwórz kilka instancji tej struktury i wyświetl ich właściwości na konsoli.
struct Product{
    var nazwa: String
    var opis: String
    var cena: Double
}

var produkt1 = Product(nazwa: "cos", opis: "Lorem Ipsum", cena: 123)

print("nazwa: \(produkt1.nazwa) opis: \(produkt1.opis) cena: \(produkt1.cena)")
