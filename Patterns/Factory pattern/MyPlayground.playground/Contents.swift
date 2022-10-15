import UIKit
// Model
struct Report {

    let id : UUID
    let year: Int
    let total: Double

    static func generateDummyReport() -> Array<Report> {

        return [Report(id: UUID(), year: Int.random(in: 2015..<2022), total: Double.random(in: 2000..<5000)),
                Report(id: UUID(), year: Int.random(in: 2015..<2022), total: Double.random(in: 2000..<5000))]
    }
}

protocol ReportProtocol {
    func getReport() -> Array<Report>
}

class TaxReport : ReportProtocol {

    func getReport() -> Array<Report> {
        print("fetching tax report")
        return Report.generateDummyReport()
    }
}

class ProfitReport : ReportProtocol {

    func getReport() -> Array<Report> {
        
        // code for calculating profit report
        print("fetching profit report")
        return Report.generateDummyReport()
    }
}

class FinanceReport : ReportProtocol {
    func getReport() -> Array<Report> {

        // code for calculating profit report
        print("fetching finance report")
        return Report.generateDummyReport()
    }
}

enum ReportType {
    case tax
    case profit
    case finance
}

class ReportFactory {
    static func create(type: ReportType) -> ReportProtocol {

        switch type {
        case .tax:
            return TaxReport()
        case .profit:
            return ProfitReport()
        case .finance:
            return FinanceReport()
        }
    }
}

class ReportViewModel {
    private let report : ReportProtocol

    init(_report : ReportProtocol) {
        report = _report
    }
    func getReport() -> Array<Report> {
        return report.getReport()
    }
}

let reportViewModel = ReportViewModel(_report: ReportFactory.create(type: .finance))
reportViewModel.getReport()
