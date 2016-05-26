//
//  HotelCollectionViewCell.h
//  Hotel
//
//  Created by Phuong on 2/11/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end
