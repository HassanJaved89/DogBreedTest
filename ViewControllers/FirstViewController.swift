//
//  BreedsViewController.swift
//  DogBreedTest
//
//  Created by Hassan Javed on 10/02/2022.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: BreedsViewModel?
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.title = "Dog Breeds"
        viewModel = BreedsViewModel()
        viewModel?.onLoad(completionHandler: { success in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "BreedCell", for: indexPath)
        cell.textLabel?.text = viewModel?.getRowTitle(index: indexPath.row).capitalized
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 20.0)
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.rowSelected(index: indexPath.row)
        
        // We can use coordinators to navigate the views so that the view controller gets completely isolated. For now I've implemented the navigation logic inside view controller.
        let secondVC: SecondViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        secondVC!.viewModel = self.viewModel
        self.navigationController?.pushViewController(secondVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
