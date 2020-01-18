//
//  TrackListCell.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/28/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit
import RxSwift

class TrackListCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var albumLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var trackImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
