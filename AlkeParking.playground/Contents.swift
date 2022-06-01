import UIKit
import Foundation

// MARK: enums
enum VehicleType {
    case car
    case moto
    case miniBus
    case bus
    
    var tarifa: Int {
        switch self {
        case .car:
            return 20
        case .moto:
            return 15
        case .miniBus:
            return 25
        case .bus:
            return 30
        }
    }
}


// MARK: protocols
protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    var checkInTime: Date { get }
    var discountCard: String? { get }
        
}

// MARK: structs
struct Parking {
    var vehicles: Set<Vehicle> = []
    
    var maximumQuotas: Int
    
    var totalIncome = (vehicleIncome : 0, totalEarnings : 0)
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish: (Bool) -> Void) {
        
        guard (vehicles.count < maximumQuotas) else {
            print("Sorry, the check-in failed (parking is full)")
            return onFinish(false)
        }
        
        guard !vehicles.contains(vehicle) else {
            print("Sorry, the check-in failed (vehicle already inside)")
            onFinish(false)
            return
        }
        
        print("Welcome to AlkeParking! - PLATE:\(vehicle.plate) -")
        vehicles.insert(vehicle)
        onFinish(true)
        
    }
    
    mutating func checkOutVehicle(plate: String, onSucces: (Int) -> Void, onError: () -> Void) -> Void{
        

        guard let vehicle = vehicles.first(where: { $0.plate == plate}) else {
            onError()
            return
        }
        
        print(vehicle.plate)
        
        let total = calculateFee(type: vehicle.type, parkedTime: vehicle.parkedTime!, hasDiscountCard: vehicle.discountCard != nil)
        
        vehicles.remove(vehicle)
        
        onSucces(total)
        
        totalIncome.vehicleIncome += 1
        totalIncome.totalEarnings += total
        
    }
    
    func calculateFee(type: VehicleType, parkedTime: Int, hasDiscountCard: Bool) -> Int {
        
        var total = type.tarifa
        
        let initialTime = 120
        let extraTime = 15
        let costExtraPerBlock = 5
        let ForHavingAdiscountCar = 15
        
        if parkedTime > initialTime {
            let timeExceeded = parkedTime - initialTime
            let numberOfBlocks: Double = (Double(timeExceeded) / Double(extraTime)).rounded(.up)
            total += Int(numberOfBlocks) * costExtraPerBlock
        }
        
        if hasDiscountCard == true {
            let descuento = (ForHavingAdiscountCar * total) / 100
            total -= descuento
        }
        return total
    }
    
    func showIncomes () {
        print("\(totalIncome.vehicleIncome) vehicles have checked out and have earnings of $\(totalIncome.totalEarnings)")
    }
    
    
    func listVehicles(){
        if vehicles.count > 0 {
            print("Total vehicles: \(vehicles.count) \n")
            vehicles.forEach { Vehicle in
                print("\(Vehicle.plate) \n")
            }
        } else {
            print("There are no vehicles in the parking lot")
        }
    }
}

struct Vehicle: Parkable, Hashable {
    
    let plate: String
    
    let type: VehicleType
    
    var checkInTime: Date
    
    var discountCard: String?
    
    var parkedTime: Int? {
        return Calendar.current.dateComponents([.minute], from:
        checkInTime, to: Date()).minute ?? 0
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
    
    static func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.plate == rhs.plate
    }
    
    
}

// MARK: Casos de prueba
var alkeParking = Parking(maximumQuotas: 20)
var vehiclesArray: [Vehicle] = [Vehicle]()

let vehicle1 = Vehicle(plate: "AA111AA", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")

let vehicle2 = Vehicle(plate: "B222BBB", type: VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle3 = Vehicle(plate: "CC333CC", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle4 = Vehicle(plate: "DD444DD", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")

let vehicle5 = Vehicle(plate: "AA111BB", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_003")

let vehicle6 = Vehicle(plate: "B222CCC", type: VehicleType.moto, checkInTime: Date(), discountCard: "DISCOUNT_CARD_004")

let vehicle7 = Vehicle(plate: "CC333DD", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle8 = Vehicle(plate: "DD444EE", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_005")

let vehicle9 = Vehicle(plate: "AA111CC", type: VehicleType.car, checkInTime: Date(), discountCard: nil)

let vehicle10 = Vehicle(plate: "B222DDD", type: VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle11 = Vehicle(plate: "CC333EE", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle12 = Vehicle(plate: "DD444GG", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_006")

let vehicle13 = Vehicle(plate: "AA111DD", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_007")

let vehicle14 = Vehicle(plate: "B222EEE", type: VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle15 = Vehicle(plate: "CC333FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle16 = Vehicle(plate: "CC334FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle17 = Vehicle(plate: "CC335FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle18 = Vehicle(plate: "CC336FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle19 = Vehicle(plate: "CC337FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle20 = Vehicle(plate: "CC338FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle21 = Vehicle(plate: "CC339FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)



vehiclesArray.append(vehicle1)
vehiclesArray.append(vehicle2)
vehiclesArray.append(vehicle3)
vehiclesArray.append(vehicle4)
vehiclesArray.append(vehicle5)
vehiclesArray.append(vehicle6)
vehiclesArray.append(vehicle7)
vehiclesArray.append(vehicle8)
vehiclesArray.append(vehicle9)
vehiclesArray.append(vehicle10)
vehiclesArray.append(vehicle11)
vehiclesArray.append(vehicle12)
vehiclesArray.append(vehicle13)
vehiclesArray.append(vehicle14)
vehiclesArray.append(vehicle15)
vehiclesArray.append(vehicle16)
vehiclesArray.append(vehicle17)
vehiclesArray.append(vehicle18)
vehiclesArray.append(vehicle19)
vehiclesArray.append(vehicle20)
vehiclesArray.append(vehicle21)


vehiclesArray.forEach { vehicle in
    alkeParking.checkInVehicle(vehicle) { _ in }
}

print("\n<< CHECK OUT >>")

alkeParking.checkOutVehicle(plate: vehiclesArray[0].plate) { total in
    print("Your fee is $\(total). Come back soon")
} onError: {
    print("Sorry, the check-out failed")
}
alkeParking.checkOutVehicle(plate: vehiclesArray[2].plate) { total in
    print("Your fee is $\(total). Come back soon")
} onError: {
    print("Sorry, the check-out failed")
}

print("\n<< VEHICLES IN THE PARKING >>")
alkeParking.listVehicles()

print("\n<< NUMBER OF RETIRED VEHICLES AND EARNINGS >>")

alkeParking.showIncomes()



// MARK: Desarrollo Ejercicios

//Ejercicio 1
//Se usan sets ya que no pueden existir dos vehiculos iguales y los sets descartan los elementos duplicados.
//Es más eficiente en memoria al no guardar los valores con un orden especifico.

//Ejercicio 2
//El vehiculo no cambia de tipo con el tiempo así que se define como let en la struct vehiculo.
//Lo más optimo es utilizar un switch ya que el código es más limpio que las demas estructuras para los casos de estudio definidos.

//Ejercicio 3
// La propiedad checkInTime se debe agregar en ambos ya que es requerida al momento del ingreso y la propiedad discountCard solo en Vehicle ya que es opcional, es decir, de tipo opcional.

//Ejercicio 4
// Se usó una computed properties

//Ejercicio 5
//Para identificar la cantidad de vehiculos del estacionamiento se utiliza la función del Set: count.

//Ejercicio 7
//Para identificar un elemento dada cierta condición en un Set se utiliza la función contains.

//Para modificar una propiedad de un struct se debe definir la función como mutating ya que el struct es de tipo valor.

//Ejercicio 10
// Para determinar si el vehiculo tiene descuento es necesario verificar si tiene o no una tarjeta de descuento, es decir, si la discountCard es diferente de nil para aplicar el descuento o si es igual a nil para no aplicarlo.
