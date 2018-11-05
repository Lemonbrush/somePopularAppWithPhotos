//
//  ContentCell.h
//  Collager
//
//  Created by Александр on 21.10.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *autor;
@property (weak, nonatomic) IBOutlet UIImageView *autorImage;

@end
