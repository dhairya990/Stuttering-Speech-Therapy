//
//  ExpertViewController.swift
//  Team_19_App
//
//  Created by Batch-1 on 20/05/24.
//

import UIKit

class ExpertViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UISearchResultsUpdating {
    
    
    
    @IBOutlet var expertCollectionView: UICollectionView!

    var filteredItems:[String] = ["Mr John","Mrs.Priya"]
    let searchController = UISearchController()
    var docData:[DoctorData] = DataController.shared.doctorData
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text,searchString.isEmpty==false{
            filteredItems = DataController.shared.items.filter{(item) -> Bool in item.localizedCaseInsensitiveContains (searchString)}
        }else{
            filteredItems = DataController.shared.items
        }
        expertCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        expertCollectionView.dataSource = self
        expertCollectionView.delegate = self
        expertCollectionView.setCollectionViewLayout(generateLayout(), animated: true)

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cells", for: indexPath) as? ExpertCollectionViewCell
        let doctor = docData[indexPath.item]
        
        cell?.doctorNameLabel.text = doctor.doctorName
        cell?.experienceLabel.text = doctor.doctorExperience
        cell?.qualficationLabel.text = doctor.doctorQualification
        //cell?.numberOfPatients.text = doctor.doctorPaitent
        cell?.ratingLabel.text = doctor.doctorRating
        cell?.imageLabel.image = UIImage(named: doctor.doctorPhoto)
//       
//        if indexPath.item % 2 == 0 {
//            cell!.contentView.backgroundColor = UIColor(red: 249/255, green: 221/255, blue: 193/255, alpha: 1.0)
//        }
//        else{
//            cell!.contentView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 252/255, alpha: 1.0)
//        }
        cell!.layer.shadowOpacity = 0.15
        cell!.layer.shadowOffset = .init(width: 0, height: 10)
        cell!.layer.shadowColor = UIColor.black.cgColor
        cell!.layer.masksToBounds = true
        cell!.layer.cornerRadius=15
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docData.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDoctor = docData[indexPath.row]
        performSegue(withIdentifier: "showDoctorDetails", sender: selectedDoctor)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDoctorDetails",let destinationVC = segue.destination as? MapViewController,let selectedDoctor = sender as? DoctorData{
            destinationVC.doctor = selectedDoctor
        }
    }
    func generateLayout() -> UICollectionViewLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(140.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15)
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
