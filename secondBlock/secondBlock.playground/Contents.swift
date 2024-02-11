// MARK: - №2
// Определить две константы a и b типа Double, присвоить им любые значения. Вычислить среднее значение и сохранить результат в переменную avarage.
let a = 3.0
let b = 5.0
var avarage: Double {
    (a + b) / 2
}

// MARK: - №3
// Создать кортеж, и задать два любых строковых значения с названиями firstName и lastName. Далее необходимо вывести в консоль строку в формате "Full name: [firstName] [lastName]".
let fullName = (firstName: "Rustem", lastName: "Tukhvatullin")
print("Full name: \(fullName.firstName) \(fullName.lastName)")

// MARK: - №4
// Создать две опциональные переменные типа Float. Одной из них задать первоначальное значение. Написать функцию, которая принимает на вход опциональную переменную типа Float. Функция должна безопасно извлечь значение из входящей переменной. Если значение удалось получить - необходимо вывести его в консоль, если значение у переменной отсутствует вывести в консоль фразу "Variable can't be unwrapped". Вызвать функцию дважды с двумя ранее созданными переменными.
var firstFloat: Float? = 3.14
var secondFloat: Float?
func extractOptional(number: Float?) {
    if let extract = number {
        print(extract)
    } else {
        print("Variable can't be unwrapped")
    }
}
extractOptional(number: firstFloat)
extractOptional(number: secondFloat)

// MARK: - №5
// Напишите программу для вывода первых 15 чисел последовательности Фибоначчи
func fibonacci(count: Int) {
    var a = 0, b = 1, c = a + b
    var result = "\(a) \(b) \(c)"
    switch count {
    case 0: print("Fibonacci numbers can't be calculated")
    case 1: print(a)
    case 2: print("\(a) \(b)")
    case 3: print(result)
    case 4...93:
        for _ in 4...count {
            a = b
            b = c
            c = a + b
            result += " \(c)"
        }
        print(result)
    default:
        print("It's too much")
    }
}
fibonacci(count: 15)

// MARK: - №6
// Напишите программу для сортировки массива, использующую метод пузырька. Сортировка должна происходить в отдельной функции, принимающей на вход исходный массив.
func bubbleSort(array: inout [Int]) {
    for i in 0...array.count - 2 {
        for j in i + 1...array.count - 1 {
            if array[i] > array[j] {
                let temp = array[i]
                array[i] = array[j]
                array[j] = temp
            }
        }
    }
}
var arr = [9, 8, 7, 1, 2, 0, 3]
bubbleSort(array: &arr)
print(arr)

// MARK: - №7
// Напишите программу, решающую задачу: есть входящая строка формата "abc123", где сначала идет любая последовательность букв, потом число. Необходимо получить новую строку, в конце которой будет число на единицу больше предыдущего, то есть "abc124".
func oneMore(input: String) -> String {
    guard let result = Int(input) else {
        var result = input
        let set = "0123456789"
        if input.count == 0 || !set.contains(input[input.index(input.endIndex, offsetBy: -1)]) {
            return input + "\(1)"
        } else {
            var number = ""
            for i in (0...result.count - 1).reversed() {
                let char = result[result.index(result.startIndex, offsetBy: i)]
                if set.contains(char) {
                    number.insert(result.removeLast(), at: number.startIndex)
                } else {
                    break
                }
            }
            return result + String(Int(number)! + 1)
        }
    }
    return String(result + 1)
}
print(oneMore(input: "0"))
