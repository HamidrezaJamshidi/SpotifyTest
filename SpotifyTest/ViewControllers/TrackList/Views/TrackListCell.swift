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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
