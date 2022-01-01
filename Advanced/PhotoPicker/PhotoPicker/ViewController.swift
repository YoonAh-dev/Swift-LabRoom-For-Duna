//
//  ViewController.swift
//  PhotoPicker
//
//  Created by SHIN YOON AH on 2021/06/19.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath) as? CVC else { return UICollectionViewCell() }
        
        let asset = list[indexPath.row]
        if let asset = asset {
            print(asset)
            cell.backgroundColor = .red
            cell.image.image = asset
            cell.image.contentMode = .scaleAspectFill
        }
        cell.number.isHidden = true
        
        return cell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var list: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "CVC", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CVC")
    }


    @IBAction func presentVC(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "PhotoVC") as? PhotoVC else {
            return
        }
        vc.listSave = { image in
            self.list.removeAll()
            self.list.append(contentsOf: image)
            print(self.list)
            self.collectionView.reloadData()
        }
        present(vc, animated: true, completion: nil)
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

