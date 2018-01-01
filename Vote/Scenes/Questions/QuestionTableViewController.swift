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
import RealmSwift

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
    
    private var refresh = Variable<()>.init(())
    
    private var questions: [QuestionModel] {
        return RealmManager.shared.fetchAll()
    }
    
    private var viewModels: [SectionOfCellVM] {
        return [SectionOfCellVM.init(
            items: questions.map {
                $0.toQuestionCellViewModel()
        })]
    }
    
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
        
        let refreshControl = UIRefreshControl.init()
        refreshControl.addTarget(
            self,
            action: #selector(refreshChanged(_:)),
            for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        // Create the animated data source with RxDataSources and configure the table view cell.
        let animatedDataSource = RxTableViewSectionedAnimatedDataSource<SectionOfCellVM>(
            configureCell: {
                dataSource, tableView, index, item in
            
                guard
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: QuestionTableViewCell.identifier)
                        as? QuestionTableViewCell
                    else { return UITableViewCell() }
                
                cell.configure(
                    withViewModel: item)
                
                return cell
        })
        
        // Use the segmented view input to decide sort method for the question and sort them accordingly.
        Observable.combineLatest(
            refresh.asObservable(),
            segmentedControl.rx.selectedSegmentIndex.asObservable())
            .flatMap {
            [weak self] (_, index: Int) -> Observable<[SectionOfCellVM]> in
            
            guard let dataSource = self?.viewModels else { return Observable.just([]) }
            
            let id: ([SectionOfCellVM]) -> [SectionOfCellVM] = { $0 }
            let voteSorted: ([SectionOfCellVM]) -> [SectionOfCellVM] = { sections in
                return sections.map { section in
                    
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
    
    @objc func refreshChanged(_ sender: Any) {
        print("sender = \(sender)")
        
        refresh.value = ()
        refreshControl?.endRefreshing()
    }
}
