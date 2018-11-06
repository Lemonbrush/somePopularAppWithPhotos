//
//  LikeButton.m
//  Collager
//
//  Created by Александр on 06.11.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import "LikeButton.h"

@implementation LikeButton

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        UIImage *imFAnim;
        if(!self.liked)
        {
            imFAnim = [UIImage imageNamed:@"activeLikeUI.png"];
            self.liked = YES;
        }
        else{
            
            imFAnim = [UIImage imageNamed:@"likeUI.png"];
            self.liked = NO;
            
        }
        
        [self setImage:imFAnim forState:UIControlStateNormal];
        
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        
        
    } completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
        
    }];
    
}

@end
