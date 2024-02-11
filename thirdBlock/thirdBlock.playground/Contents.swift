// MARK: - №2
// Написать простое замыкание в переменной myClosure, замыкание должно выводить в консоль фразу "I love Swift". Вызвать это замыкание. Далее написать функцию, которая будет запускать заданное замыкание заданное количество раз. Объявить функцию так: func repeatTask (times: Int, task: () -> Void). Функция должна запускать times раз замыкание task . Используйте эту функцию для печати «I love Swift» 10 раз.

var myClosure = { print("I love Swift") }
myClosure()

func repeatTask(times: Int, task: () -> Void) {
    for _ in 1...times {
        task()
    }
}
repeatTask(times: 10, task: myClosure)

// MARK: - №3
//Условия: есть начальная позиция на двумерной плоскости, можно осуществлять последовательность шагов по четырем направлениям up, down, left, right. Размерность каждого шага равна 1. Создать перечисление Directions с направлениями движения. Создать переменную location с начальными координатами (0,0), создать массив элементами которого будут направления из перечисления. Положить в этот массив следующую последовательность шагов: [.up, .up, .left, .down, .left, .down, .down, .right, .right, .down, .right]. Програмно вычислить какие будут координаты у переменной location после выполнения этой последовательности шагов.

typealias Coordinate = (x: Int, y: Int)

enum Directions {
    case up
    case down
    case left
    case right

    func step() -> Coordinate {
        switch self {
        case .up:
            return (0, 1)
        case .down:
            return (0, -1)
        case .left:
            return (-1, 0)
        case .right:
            return (1, 0)
        }
    }
}

func calculatedCurrentLocation(start location: inout Coordinate, path: [Directions]) {
    for move in path {
        let currentStep = move.step()
        location.x += currentStep.x
        location.y += currentStep.y
    }
}

var location: Coordinate = (0, 0)
let path: [Directions] = [.up, .up, .left, .down, .left, .down, .down, .right, .right, .down, .right]
calculatedCurrentLocation(start: &location, path: path)
print("Current location is (\(location.x), \(location.y)).")

// MARK: - №4
//Создать класс Rectangle с двумя неопциональными свойствами: ширина и длина. Реализовать в этом классе метод вычисляющий и выводящий в консоль периметр прямоугольника. Создать экземпляр класса и вызвать у него этот метод.
class Rectangle {
    let height: Int
    let width: Int

    init(height: Int, width: Int) {
        self.height = height
        self.width = width
    }

    func calculedPerimetr() -> Int {
        let perimetr = (height + width) * 2
        print("Perimetr of rectangle with height = \(height) and width = \(width) is \(perimetr).")
        return perimetr
    }
}

let rectangle = Rectangle(height: 3, width: 5)
rectangle.calculedPerimetr()

// MARK: - №5
//Создать расширение класса Rectangle, которое будет обладать вычисляемым свойством площадь. Вывести в консоль площадь уже ранее созданного объекта.

extension Rectangle {
    var square: Int {
        width * height
    }
}
print("Square of rectangle with height = \(rectangle.height) and width = \(rectangle.width) is \(rectangle.square).")
