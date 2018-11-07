//
//  LikeButton.h
//  Collager
//
//  Created by Александр on 06.11.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikeButton : UIButton

@property bool liked;
@property (nonatomic, weak) NSMutableDictionary *contentData;

@end
