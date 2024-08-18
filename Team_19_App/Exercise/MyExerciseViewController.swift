//
//  ViewController.swift
//  ExerciseNew5
//
//  Created by Dhairya bhardwaj on 02/06/24.
//

import UIKit

class MyExerciseViewController: UIViewController {
   
    @IBOutlet weak var collectionView: UICollectionView!

    private var sections: [Section] = []
       private var selectedNumber: Int? = 1
       private var originalImageLabels: [ImageLabelItem] = []
       private weak var dailyExerciseViewController: DailyExerciseViewController?
       
       // Define arrays of audio URLs
    private var evenNumberAudioURLs: [[URL]] = []
        private var oddNumberAudioURLs: [[URL]] = []
    //private var imageLabelAudioURLs: [[URL]] = []
    var numbers: [NumberItem] {
            return DataController.shared.numbers
        }
     
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           collectionView.backgroundColor = .white
               collectionView.dataSource = self
               collectionView.delegate = self
               
               collectionView.register(UINib(nibName: "NumberCell", bundle: nil), forCellWithReuseIdentifier: "First")
               collectionView.register(UINib(nibName: "ImageOnlyCell", bundle: nil), forCellWithReuseIdentifier: "Third")
               collectionView.register(UINib(nibName: "ImageLabelCell", bundle: nil), forCellWithReuseIdentifier: "Second")
               
               collectionView.setCollectionViewLayout(createLayout(), animated: false)
               loadAudioFiles()
               //loadMockData()
               loadSections()
               if let imageLabelSection = sections.first(where: { $0.type == .imageLabel }) {
                   originalImageLabels = imageLabelSection.items as! [ImageLabelItem]
               }
               
               
           }
    
   
        //fetch
    func loadAudioFiles() {
            evenNumberAudioURLs = [
                [
                    Bundle.main.url(forResource: "even_audio1_intro", withExtension: "mp4")!,
                    Bundle.main.url(forResource: "even_audio1_module", withExtension: "mp4")!
    
                ],
                [
    
                    Bundle.main.url(forResource: "even_audio2_module", withExtension: "mp4")!
    
                ],
                [
                    Bundle.main.url(forResource: "even_audio2_practice", withExtension: "mp4")!,
                    Bundle.main.url(forResource: "even_audio2_practice", withExtension: "mp4")!
    
                ],
                [
                    Bundle.main.url(forResource: "even_audio2_conclusion", withExtension: "mp4")!
    
                ],
            ]
    
            oddNumberAudioURLs = [
                [
                    Bundle.main.url(forResource: "odd_audio1_intro", withExtension: "mp4")!,
    
                ],
                [
                    Bundle.main.url(forResource: "odd_audio1_module", withExtension: "mp4")!,
                    Bundle.main.url(forResource: "odd_audio1_module", withExtension: "mp4")!
                ],
                [
                    Bundle.main.url(forResource: "odd_audio1_practice", withExtension: "mp4")!
                ],
                [
                    Bundle.main.url(forResource: "odd_audio1_practice", withExtension: "mp4")!,
                    Bundle.main.url(forResource: "odd_audio1_practice", withExtension: "mp4")!
                ]
    
            ]
        }

        func updateAudioURLs(for selectedNumber: Int) {
            guard let imageLabelSectionIndex = sections.firstIndex(where: { $0.type == .imageLabel }) else {
                return
            }

            let audioURLs = selectedNumber % 2 == 0 ? evenNumberAudioURLs : oddNumberAudioURLs

            let imageLabelItems = sections[imageLabelSectionIndex].items as! [ImageLabelItem]

            for (index, imageLabelItem) in imageLabelItems.enumerated() {
                imageLabelItem.audioFileURLs = audioURLs[index % audioURLs.count]
                //imageLabelItem.currentAudioIndex = 0 // Reset to the first audio
                //DataController.shared.updateImageLabelItem(imageLabelItem)
            }

            collectionView.reloadSections(IndexSet(integer: imageLabelSectionIndex))
        }
    func loadSections() {
            let numberSection = Section(type: .number, items: numbers)
            let imageLabelSection = Section(type: .imageLabel, items: DataController.shared.imageLabels)
            let imageOnlySection = Section(type: .imageOnly, items: DataController.shared.imageOnlyItems)
            
            sections = [numberSection, imageOnlySection, imageLabelSection]
            
            updateAudioURLs(for: selectedNumber ?? 1) // Update audio URLs based on the default selected number
        }
    func createLayout() -> UICollectionViewLayout {
            return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
                switch self.sections[sectionIndex].type {
                case .number:
                    return self.createNumberSection()
                case .imageOnly:
                    return self.createImageOnlySection()
                case .imageLabel:
                    return self.createImageLabelSection()
                }
            }
        }
    
    func createNumberSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(60), heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(60), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    func createImageOnlySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    
    func createImageLabelSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 25
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    
}
extension MyExerciseViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        
        switch section.type {
        case .number:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "First", for: indexPath) as? NumberCell else {
                fatalError("Error: Cannot dequeue NumberCell")
            }
            if let numberItem = section.items[indexPath.row] as? NumberItem {
                cell.configure(with: numberItem.value, isSelected: numberItem.isSelected)
            }
            return cell
            
        case .imageOnly:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Third", for: indexPath) as? ImageOnlyCell else {
                fatalError("Error: Cannot dequeue ImageOnlyCell")
            }
            if let imageOnlyItem = section.items[indexPath.row] as? ImageOnlyItem {
                cell.configure(with: imageOnlyItem.imageName, greeting: "Good")
            }
            return cell
            
        case .imageLabel:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Second", for: indexPath) as? ImageLabelCell else {
                fatalError("Error: Cannot dequeue ImageLabelCell")
            }
            if let imageLabelItem = section.items[indexPath.row] as? ImageLabelItem {
                // Ensure audio URL is retrieved safely
                if let audioURL = imageLabelItem.getCurrentAudioURL() {
                    print("Successfully retrieved audio URL: \(audioURL)") // Logging
                } else {
                    print("Failed to retrieve audio URL") // Logging
                }
                cell.configure(with: imageLabelItem.imageName, label: imageLabelItem.labelText, duration: imageLabelItem.duration)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        
        if section.type == .number, let numberItem = section.items[indexPath.row] as? NumberItem {
            let previouslySelectedNumber = selectedNumber
            selectedNumber = numberItem.value
            
            if let previouslySelectedNumber = previouslySelectedNumber,
               let previousIndex = sections[indexPath.section].items.firstIndex(where: { ($0 as? NumberItem)?.value == previouslySelectedNumber }) {
                var previousNumberItem = sections[indexPath.section].items[previousIndex] as! NumberItem
                previousNumberItem.isSelected = false
                sections[indexPath.section].items[previousIndex] = previousNumberItem
                let previousIndexPath = IndexPath(item: previousIndex, section: indexPath.section)
                collectionView.reloadItems(at: [previousIndexPath])
            }
            
            var updatedNumberItem = numberItem
            updatedNumberItem.isSelected = true
            sections[indexPath.section].items[indexPath.row] = updatedNumberItem
            collectionView.reloadItems(at: [indexPath])
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            // Update the audio file URLs in the ImageLabelCell section based on the selected number
            updateAudioURLs(for: selectedNumber!)
        } else if section.type == .imageLabel, let imageLabelItem = section.items[indexPath.row] as? ImageLabelItem {
            performSegue(withIdentifier: "showDailyExercise", sender: imageLabelItem)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDailyExercise",
           let destinationVC = segue.destination as? DailyExerciseViewController,
           let imageLabelItem = sender as? ImageLabelItem {
            destinationVC.imageLabelItem = imageLabelItem
        }
        
    }
}
