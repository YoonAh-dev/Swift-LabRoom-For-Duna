//
//  ViewController.swift
//  BSPhotoPicker
//
//  Created by SHIN YOON AH on 2021/06/20.
//

import UIKit
import BSImagePicker
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userSelectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath) as? CVC else { return UICollectionViewCell() }
        
        cell.backgroundColor = .red
        cell.image.contentMode = .scaleToFill
        cell.image.image = userSelectedImages[indexPath.row]
        
        return cell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedAssets: [PHAsset] = []
    var userSelectedImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CVC.self, forCellWithReuseIdentifier: "CVC")
    }

    @IBAction func pressedAddButton(_ sender: Any) {
        selectedAssets.removeAll()
        userSelectedImages.removeAll()
        
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 5
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePicker.settings.theme.selectionStyle = .numbered
        imagePicker.settings.theme.selectionFillColor = .systemRed
        imagePicker.settings.theme.selectionStrokeColor = .white
                
        imagePicker.modalPresentationStyle = .fullScreen
        
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            // User finished selection assets.
            for i in 0..<assets.count {
                self.selectedAssets.append(assets[i])
            }
            self.convertAssetToImages()
//          self.delegate?.didPickImagesToUpload(images: self.userSelectedImages)
            print("selectedAssets: \(self.selectedAssets)")
            self.collectionView.reloadData()
        })
    }
    
    func convertAssetToImages() {
        if selectedAssets.count != 0 {
            for i in 0..<selectedAssets.count {
                let imageManager = PHImageManager.default()
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                option.version = .original
                var thumbnail = UIImage()
                
                imageManager.requestImage(for: selectedAssets[i],
                                            targetSize: CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.width/3),
                                            contentMode: .aspectFit,
                                            options: option) { (result, info) in
                    guard let result = result else { return }
                    thumbnail = result
                }
                
                let data = thumbnail.jpegData(compressionQuality: 1)
                let newImage = UIImage(data: data!)
                
                self.userSelectedImages.append(newImage! as UIImage)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
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

