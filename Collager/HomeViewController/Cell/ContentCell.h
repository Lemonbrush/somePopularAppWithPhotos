//
//  ContentCell.h
//  Collager
//
//  Created by Александр on 21.10.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import "LikeButton.h"
#import <UIKit/UIKit.h>

@interface ContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UILabel *autor;
@property (weak, nonatomic) IBOutlet UIImageView *autorImage;
@property (weak, nonatomic) IBOutlet LikeButton *likeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHC;

@end
