//
//  QuestionTableViewController.swift
//  Vote
//
//  Created by Tiziano Coroneo on 03/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

fileprivate struct SectionOfCellVM: AnimatableSectionModelType {
    typealias Identity = Int
    typealias Item = QuestionTableViewCell.ViewModel
    
    var identity: Int { return "asdlkjasd".hashValue }
    var items: [SectionOfCellVM.Item]
}

extension SectionOfCellVM {
    init(original: SectionOfCellVM, items: [Item]) {
        self = original
        self.items = items
    }
}

class QuestionTableViewController: UITableViewController {
    
    typealias CellVM = QuestionTableViewCell.ViewModel
   
    var style: StyleGuide = AppDelegate.style

    private let viewModels = [SectionOfCellVM.init(items: [
        CellVM(
            shouldDisplayAnswer: true,
            hour: "09:42",
            answerVoteCount: 42,
            totalVoteCount: 120,
            question: "Why Trump 1?",
            answer: "I love Haskell 1"),
        CellVM(
            shouldDisplayAnswer: false,
            hour: "09:42",
            answerVoteCount: 42,
            totalVoteCount: 110,
            question: "Why Trump 2?",
            answer: "I love Haskell 2"),
        CellVM(
            shouldDisplayAnswer: true,
            hour: "09:42",
            answerVoteCount: 42,
            totalVoteCount: 130,
            question: "Why Trump? 3",
            answer: "I love Haskell 3")
        ])]
    
    private let disposeBag = DisposeBag()
    private var segmentedControl: UISegmentedControl! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupTableView()
    }
    
    private func setupNavbar() {
        segmentedControl = UISegmentedControl(items: ["Latest", "Most voted"])
        segmentedControl.sizeToFit()
        segmentedControl.tintColor = UIColor.voteDarkGrey
        segmentedControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = segmentedControl
    }
    
    private func setupTableView() {
        tableView.dataSource = nil
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        // Create the animated data source with RxDataSources and configure the table view cell.
        let animatedDataSource = RxTableViewSectionedAnimatedDataSource<SectionOfCellVM>(
            configureCell: {
                [weak self]
                dataSource, tableView, index, item in
            
                guard
                    let style = self?.style.textTableViewCellStyle,
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: QuestionTableViewCell.identifier)
                        as? QuestionTableViewCell
                    else { return UITableViewCell() }
                
                cell.configure(
                    withViewModel: item,
                    withStyle: style)
                
                return cell
        })
        
        // Use the segmented view input to decide sort method for the question and sort them accordingly.
        segmentedControl.rx.selectedSegmentIndex.flatMap {
            [weak self] (index: Int) -> Observable<[SectionOfCellVM]> in
            
            guard let dataSource = self?.viewModels else { return Observable.just([]) }
            
            let id: ([SectionOfCellVM]) -> [SectionOfCellVM] = { $0 }
            let voteSorted: ([SectionOfCellVM]) -> [SectionOfCellVM] = { sections in
                return sections.map { section in
                    print("Sorting")
                    let sorted = section.items.sorted(by: { a, b in
                        a.totalVoteCount > b.totalVoteCount
                    })
                    return SectionOfCellVM(items: sorted)
                }
            }
            
            return Observable<[SectionOfCellVM]>.just(
                (index == 0 ? id : voteSorted)(dataSource))
            }.bind(to: tableView.rx.items(
                dataSource: animatedDataSource))
            .disposed(by: disposeBag)
    }
}
