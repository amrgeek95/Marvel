//
//  MarvelCharactersViewController.swift
//  Marvel
//
//  Created by Mac on 23/11/2022.
//

import UIKit

class characterDetailViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    
    
    @IBOutlet weak var notFoundView: UIView!
    @IBOutlet weak var listTableView : UITableView!
    
    var marvel : Marvel!
    
    private var characterDetailVM : characterDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard marvel.id != 0 else {return animateView(view: self.notFoundView, hidden: false)}
        
        self.characterDetailVM = characterDetailViewModel()

        self.characterDetailVM.getItemDetail(id: marvel.id, type: "series", url: "series")
        self.characterDetailVM.getItemDetail(id: marvel.id, type: "comics", url: "comics")
        self.characterDetailVM.getItemDetail(id: marvel.id, type: "stories", url: "stories")
        setDelegate()
        
        setBinder()
        // Do any additional setup after loading the view.
    }
    func setDelegate(){
        listTableView.register(
            characeterDetailTopItemTableViewCell.nib(), forCellReuseIdentifier: characeterDetailTopItemTableViewCell.cellIdentifier)
        
        listTableView.register(MarvelCharacterTableViewCell.nib(), forCellReuseIdentifier: MarvelCharacterTableViewCell.cellIdentifier)

        self.listTableView.delegate = self
        self.listTableView.dataSource = self
    }
    
    private func setBinder(){
        self.listTableView.reloadData()
        self.characterDetailVM.Stories.bind({
            [weak self] list in
            print(list?.items)
            
            if let list = list {
                self?.listTableView.reloadSections(IndexSet(integer: 2), with: .none)
            }
        })
        
        self.characterDetailVM.Comics.bind({
            [weak self] list in
            print(list?.items)
            
            if let list = list {
                self?.listTableView.reloadSections(IndexSet(integer: 1), with: .none)
            }
        })
        
        self.characterDetailVM.Series.bind({
            [weak self] list in
            print(list?.items)
            
            if let list = list {
                
                self?.listTableView.reloadSections(IndexSet(integer: 3), with: .none)
            }
        })
    }
    func animateView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }

}
extension characterDetailViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: characeterDetailTopItemTableViewCell.cellIdentifier) as! characeterDetailTopItemTableViewCell
            cell.configure(with: marvel)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelCharacterTableViewCell.cellIdentifier) as! MarvelCharacterTableViewCell
            let index = indexPath.section

            switch index {
            case 1:
                guard let data = self.characterDetailVM.Comics.value else {return cell}
                        
                cell.configure(with: data, title: "Comics")
                return cell
            case 2:
                guard let data = self.characterDetailVM.Stories.value else {return cell}
                        
                cell.configure(with: data, title: "Stories")

            case 3:
                guard let data = self.characterDetailVM.Series.value else {return cell}
                        
                cell.configure(with: data, title: "Series")
                        
            default:
                break;
            }
            return cell

        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }else{
            return ((UIScreen.main.bounds.size.width / 2.0) + 100.0)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else  {

            switch section {
            case 1:
                let count = self.characterDetailVM.Comics.value?.items.count ?? 0
                return (count > 0 ) ? 1 : 0
            case 2:
                let count = self.characterDetailVM.Stories.value?.items.count ?? 0
                return (count > 0 ) ? 1 : 0
            case 3:
                let count = self.characterDetailVM.Series.value?.items.count ?? 0
                return (count > 0 ) ? 1 : 0

            default:
                return 0
            }
            
            return  0
        }
    }
}
