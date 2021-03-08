//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Ariel Cobena on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    var favorited:Bool = false
    var retweeted:Bool = false
    var tweetId:Int = -1
    
    func  setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        if(favorited) {
            favoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            favoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweetButton(_ sender: Any) {
        
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error is retweeting: \(error)")
        })
        
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        
        let tobeFaovrited = !favorited
        
        if(tobeFaovrited) {
            
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
            
        } else {
            
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                
                self.setFavorite(false)
                
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
