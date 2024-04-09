struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
enum CustomError: Error {
    case InvalidCurrency
}
struct Money {
    var amount: Int
    var currency: String
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    static func create(amount: Int, currency: String) throws -> Money {
        guard ["USD", "CAD", "EUR", "GBP"].contains(currency) else {
            throw CustomError.InvalidCurrency
        }
        
        return Money(amount: amount, currency: currency)
    }
    
    
    func convert(_ convertTo: String) -> Money {
        var currAmount = Double(self.amount)
        
        //Convert to USD first
        switch currency {
        case "GBP":
            currAmount = currAmount / 0.5
        case "EUR":
            currAmount = currAmount / 1.5
        case "CAN":
            currAmount = currAmount / 1.25
        default:
            break
        }
        
        switch convertTo {
        case "GBP":
            currAmount = currAmount * 0.5
        case "EUR":
            currAmount = currAmount * 1.5
        case "CAN":
            currAmount = currAmount * 1.25
        default:
            return Money(amount: Int(currAmount), currency: convertTo)
        }
        
        //Convert to desired currency
        return Money(amount: Int(currAmount), currency: convertTo)
    }
    
    func add(_ money: Money) -> Money {
        let newMoney = self.convert(money.currency)
        return Money(amount: newMoney.amount + money.amount, currency: money.currency)
    }
    func subtract(_ money: Money) -> Money {
        let newMoney = self.convert(money.currency)
        return Money(amount: newMoney.amount - money.amount, currency: money.currency)
    }
    
}

////////////////////////////////////
// Job
//
public class Job {
    var title: String
    var type: JobType
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    
    func calculateIncome(_ hours: Int) -> Int{
        switch self.type {
        case .Hourly(let hourly):
            return Int(hourly * Double(hours))
        case .Salary(let salary):
            if hours <= 2000 {
                return Int(salary)
            } else {
                let years = hours / 2000
                return Int(salary) * years
            }
            
        }
    
    }
    
    
    func raise(byAmount: Double) {
        switch self.type {
        case .Hourly(let hourly):
            self.type = .Hourly(hourly + byAmount)
        case .Salary(let salary):
            self.type = .Salary(salary + UInt(byAmount))
        }
    }
    
    func raise(byPercent: Double) {
        switch self.type {
        case.Hourly(let hourly):
            self.type = .Hourly(hourly + (hourly * byPercent))
        case.Salary(let salary):
            let percent = Double(salary) * byPercent
            self.type = .Salary(salary + UInt(percent))
        }
    }
    
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}

















