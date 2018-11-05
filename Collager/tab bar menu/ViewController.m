//
//  ViewController.m
//  Collager
//
//  Created by Александр on 20.10.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "ContentCell.h"

@interface ViewController ()

@property int previousIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    _homeVC = [storyboard instantiateViewControllerWithIdentifier:@"home"];
    _searchVC = [storyboard instantiateViewControllerWithIdentifier:@"lupa"];
    _plusVC = [storyboard instantiateViewControllerWithIdentifier:@"plus"];
    _likesVC = [storyboard instantiateViewControllerWithIdentifier:@"heart"];
    _profileVC = [storyboard instantiateViewControllerWithIdentifier:@"profile"];
    
    _viewControllers = [NSArray arrayWithObjects:_homeVC, _searchVC, _plusVC, _likesVC, _profileVC, nil];
    
    _selectedIndex = 0;
    _previousIndex = _selectedIndex;
    
    UIViewController * currentVC = _viewControllers[_selectedIndex];
    [self addChildViewController:currentVC];
    currentVC.view.frame = _contentViewController.bounds;
    [_contentViewController addSubview:currentVC.view];
    [currentVC didMoveToParentViewController:self];
    
}

- (IBAction)didPressTab:(UIButton *)sender;
{
    
    //удаляем прошлый контроллер
    UIViewController * previousVC = _viewControllers[_previousIndex];
    [previousVC willMoveToParentViewController:nil];
    [previousVC.view removeFromSuperview];
    [previousVC removeFromParentViewController];
    
    _selectedIndex = [sender.restorationIdentifier intValue];
    
    //запускаем новый контроллер
    UIViewController * currentVC = _viewControllers[_selectedIndex];
    [self addChildViewController:currentVC];
    currentVC.view.frame = _contentViewController.bounds;
    [_contentViewController addSubview:currentVC.view];
    [currentVC didMoveToParentViewController:self];
    
    _previousIndex = _selectedIndex;
    
    /*
    
    switch([sender.restorationIdentifier intValue])
    {
        case 0:
        {
            [sender setImage:[UIImage imageNamed:@"tapHomeUI.png"] forState:UIControlStateNormal];
            break;
        }
            
        case 1:
        {
            //[sender setImage:[UIImage imageNamed:@"tapHomeUI.png"] forState:UIControlStateNormal];
            break;
        }
            
        case 2:
        {
            //[sender setImage:[UIImage imageNamed:@"tapHomeUI.png"] forState:UIControlStateNormal];
            break;
        }
            
        case 3:
        {
            //[sender setImage:[UIImage imageNamed:@"tapHomeUI.png"] forState:UIControlStateNormal];
            break;
        }
            
        case 4:
        {
            //[sender setImage:[UIImage imageNamed:@"tapHomeUI.png"] forState:UIControlStateNormal];
            break;
        }
    }
     
     */
    
}


@end
