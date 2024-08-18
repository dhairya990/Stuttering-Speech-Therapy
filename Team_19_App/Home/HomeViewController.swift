
import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let images = ["bar-graph", "vidgame", "breathing", "test-paper"]
    let labels = ["Progress", "Games","Breathing Exercise", "Quick Test" ]
    let themeColors: [UIColor] = [
        UIColor(named: "E5E5FC") ?? .white
    ]
    
    @IBOutlet var userNameOnHome: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var viewHome: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHome.layer.shadowRadius = 10
        viewHome.layer.shadowOpacity = 0.15
        viewHome.layer.shadowOffset = .init(width: 0, height: 10)
        viewHome.layer.shadowColor = UIColor.black.cgColor
        viewHome.layer.masksToBounds = false
        
        collectionView.layer.shadowRadius = 5
        collectionView.layer.shadowOpacity = 0.15
        collectionView.layer.shadowOffset = .init(width: 0, height: 5)
        collectionView.layer.shadowColor = UIColor.gray.cgColor
        collectionView.layer.masksToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(red: 249/255, green: 221/255, blue: 193/255, alpha: 1.0).cgColor , UIColor.secondarySystemBackground.cgColor, UIColor.systemBackground.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
                viewHome.addGestureRecognizer(tapGestureRecognizer)
                viewHome.isUserInteractionEnabled = true
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CustomCell")
        
        viewHome.roundCorners([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 20)
        viewHome.roundCorners([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 15)
        imageProfile.roundCorners([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 25)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
               // print("View was tapped")
            performSegue(withIdentifier: "MoveToExercise", sender: nil)
            }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.backgroundColor = themeColors[indexPath.row % themeColors.count]
        cell.myLabel.text = labels[indexPath.row]
        cell.imageview.image = UIImage(named: images[indexPath.row])
        
        
        cell.contentView.backgroundColor = UIColor(red: 249/255, green: 221/255, blue: 193/255, alpha: 1.0)
        if indexPath.item % 3 == 0 {
            cell.contentView.backgroundColor = UIColor(red: 249/255, green: 221/255, blue: 193/255, alpha: 1.0)
        }
        else{
            cell.contentView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 252/255, alpha: 1.0)
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width / 2) - 40
        let cellHeight = cellWidth
        return CGSize(width: 172, height: 115)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "Progress", sender: nil)
        case 1:
            performSegue(withIdentifier: "Game", sender: nil)
        case 2:
            performSegue(withIdentifier: "Breathing", sender: nil)
        case 3:
            performSegue(withIdentifier: "Speech", sender: nil)
            
        
            
        default:
            performSegue(withIdentifier: "Pumpkin", sender: nil)
        }
    }
    
    @IBAction func userProfileButtonTapped(_ sender: UIButton) {
        //self.performSegue(withIdentifier: "UserProfile", sender: self)
    }
}
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *){
            var cornerMask = CACornerMask()
            if (corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains (.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask
        }
    }
        
}




