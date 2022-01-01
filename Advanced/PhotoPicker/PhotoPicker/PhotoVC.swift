//
//  PhotoVC.swift
//  PhotoPicker
//
//  Created by SHIN YOON AH on 2021/06/19.
//

import UIKit
import Photos

extension UIImageView {
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
        let options = PHImageRequestOptions()
        options.version = .original
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
            guard let image = image else { return }
            self.contentMode = .scaleAspectFill
            self.image = image
        }
    }
}

class PhotoVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photocount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath) as? CVC else { return UICollectionViewCell() }
        
        let asset = allPhotos?.object(at: indexPath.row)
        print(asset)
        if let asset = asset {
            cell.image.fetchImage(asset: asset, contentMode: .aspectFit, targetSize: cell.image.frame.size)
        }
        cell.number.isHidden = true
        
        return cell
    }

    @IBOutlet weak var photoCV: UICollectionView!
    
    var list: [UIImage?] = []
    
    var listSave: (([UIImage?]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCV.dataSource = self
        photoCV.delegate = self
        
        let nib = UINib(nibName: "CVC", bundle: nil)
        photoCV.register(nib, forCellWithReuseIdentifier: "CVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CVC
        
        if cell.didSelected {
            cell.contentView.backgroundColor = UIColor.clear
            cell.image.alpha = 1
            cell.number.isHidden = true
        
            var cnt = 0
            for i in list {
                if i == cell.image.image {
                    break
                }
                cnt += 1
            }
            list.remove(at: cnt)
            print(list)
        } else {
            cell.contentView.backgroundColor = UIColor.white
            cell.image.alpha = 0.75
            cell.number.setTitle("\(list.count + 1)", for: .normal)
            cell.number.isHidden = false
            list.append(cell.image.image)
            print(list)
        }
        cell.didSelected.toggle()
    }

    @IBAction func save(_ sender: Any) {
        listSave?(list)
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
