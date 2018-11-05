//
//  HomeVC.h
//  Collager
//
//  Created by Александр on 30.10.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property IBOutlet UITableView *mainTableView;

@end
