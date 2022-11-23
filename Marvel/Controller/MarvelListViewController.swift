//
//  MarvelListViewController.swift
//  Marvel
//
//  Created by Mac on 22/11/2022.
//

import UIKit

class MarvelListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    
    @IBOutlet weak var notFoundView: UIView!
    private var marvelViewModel : MarvelListViewModel!
    @IBOutlet weak var listTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        self.marvelViewModel = MarvelListViewModel()
        self.marvelViewModel.fetchMarvelListData()
        
        setBinder()
        
        // Do any additional setup after loading the view.
    }
    
    private func setBinder(){
        
        self.marvelViewModel.result.bind({
            [weak self] list in
            print(list)
            if let list = list {
                if list.marvels.isEmpty {
                    self?.animateView(view: self!.notFoundView, hidden: false)
                }else{
                    self?.animateView(view: self!.notFoundView, hidden: true)
                }
                self?.listTableView.reloadData()
            }
            
        })
    }
    func animateView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }

    
    private func setDelegate() {
        listTableView.register(MarvelListTableViewCell.nib(), forCellReuseIdentifier: MarvelListTableViewCell.cellIdentifier)
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.estimatedRowHeight = 100
        self.listTableView.rowHeight = UITableView.automaticDimension
        
    }
    
}
extension MarvelListViewController {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.marvelViewModel.result.value?.marvels.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarvelListTableViewCell.cellIdentifier) as! MarvelListTableViewCell
        
        guard let item = self.marvelViewModel.result.value?.marvels[indexPath.row] as? Marvel ?? nil else { return cell }
        cell.configure(with: item)

        return cell
    }
}
