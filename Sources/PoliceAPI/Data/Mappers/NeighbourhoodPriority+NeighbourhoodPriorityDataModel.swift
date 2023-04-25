import Foundation

extension NeighbourhoodPriority {

    init(dataModel: NeighbourhoodPriorityDataModel) {
        self.init(
            issue: dataModel.issue.htmlStripped,
            issueDate: dataModel.issueDate,
            action: dataModel.action?.htmlStripped,
            actionDate: dataModel.actionDate
        )
    }

}
