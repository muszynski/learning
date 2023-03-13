//Napisz program, który wyświetli wszystkie liczby parzyste od 0 do 100.

for i in stride(from: 0, to: 100, by: 2){
    print(i)
}
//Napisz program, który wyświetli wszystkie liczby nieparzyste od 0 do 50.

for i in stride(from: 1, to: 50, by: 2){
    print(i)
}
//Napisz program, który obliczy sumę liczb od 1 do 100 i wyświetli ją na ekranie.
for i in 1...100{
    print(i + i)
}
//Napisz program, który wyświetli tabliczkę mnożenia dla liczby 7.
for i in 1...10{
    print("7 x \(i) = \(7 * i)")
}
//Napisz program, który wyświetli wszystkie liczby od 1 do 100, ale zastąpi liczby podzielne przez 3 słowem "Fizz" i liczby podzielne przez 5 słowem "Buzz".
for i in 1...100{
    if i % 3 == 0{
        print("Fizz")
    } else{
        print("Buzz")
    }
}

//Napisz program, który wyświetli wszystkie liczby od 1 do 100, ale zastąpi liczby podzielne przez 3 i 5 słowem "FizzBuzz".

for i in 1...100{
    if i % 3 == 0 && i % 5 == 0{
        print("FizzBuzz")
    } else{
        print(i)
    }
}

//Napisz program, który obliczy sumę kwadratów liczb od 1 do 10 i wyświetli ją na ekranie.

//FIXME: napisz to

//Napisz program, który wyświetli wszystkie liczby pierwsze od 1 do 50.

func isPrime(_ number: Int) -> Bool {
    if number <= 1 {
        return false
    }
    
    for i in 2..<number {
        if number % i == 0 {
            return false
        }
    }
    return true
}

for i in 1...50 {
    if isPrime(i) {
        print(i)
    }
}

//Napisz program, który pobierze od użytkownika liczbę i wyświetli wszystkie liczby pierwsze mniejsze lub równe od tej liczby.

print("Podaj liczbę całkowitą")

if let input = readLine(), let number = Int(input){
    print("podana liczba to: \(number)")
} else{
    print("zły wpis")
}
//Napisz program, który pobierze od użytkownika liczbę i obliczy jej silnię za pomocą pętli while lub repeat-while.
