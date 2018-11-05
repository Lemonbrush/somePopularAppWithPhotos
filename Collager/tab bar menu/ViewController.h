//
//  ViewController.h
//  Collager
//
//  Created by Александр on 20.10.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

////////////////////////////////////////////////////////////////

@property IBOutlet UIView *contentViewController;

@property IBOutletCollection(UIButton) NSArray *buttons;

@property IBOutlet UIButton *tbHome;
@property IBOutlet UIButton *tbSearch;
@property IBOutlet UIButton *tbPlus;
@property IBOutlet UIButton *tbLikes;
@property IBOutlet UIButton *tbProfile;

@property NSArray *viewControllers;
@property int selectedIndex;

@property UIViewController *homeVC;
@property UIViewController *searchVC;
@property UIViewController *plusVC;
@property UIViewController *likesVC;
@property UIViewController *profileVC;

@end

