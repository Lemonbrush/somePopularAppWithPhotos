//
//  ContentCell.m
//  Collager
//
//  Created by Александр on 21.10.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import "ContentCell.h"

@interface ContentCell()
{
}
@end

@implementation ContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //[delegate customCell:self button1Pressed:self.AddGoPoint];
    
    //[self.comment setTitle:@"FFGF" forState:UIControlStateNormal];
    
}

- (IBAction)commentTapped:(id)sender
{
    //self.comment.titleLabel.numberOfLines = 0;
    self->_commentHC.constant = 500;
    
    //[self layoutIfNeeded]; // Ensures that all pending layout operations have been completed
    [UIView animateWithDuration:1.0 animations:^{
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
         // Forces the layout of the subtree animation block and then captures all of the frame changes
    }];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end
