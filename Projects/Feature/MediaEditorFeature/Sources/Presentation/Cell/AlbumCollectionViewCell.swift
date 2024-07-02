//
//  AlbumCollectionViewCell.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVKit
import AVFoundation
import Photos
import Common
import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: Initializer
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setImage(info: AssetInfo) {
        imageView.image = info.image
    }
}

extension AlbumCollectionViewCell: Reusable { }
