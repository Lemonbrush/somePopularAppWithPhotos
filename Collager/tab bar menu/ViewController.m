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
@property NSArray *tappedButtonName;
@property NSArray *buttonName;
@property UIButton *activeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //названия экранов
    _homeVC = [storyboard instantiateViewControllerWithIdentifier:@"home"];
    _searchVC = [storyboard instantiateViewControllerWithIdentifier:@"lupa"];
    _plusVC = [storyboard instantiateViewControllerWithIdentifier:@"plus"];
    _likesVC = [storyboard instantiateViewControllerWithIdentifier:@"heart"];
    _profileVC = [storyboard instantiateViewControllerWithIdentifier:@"profile"];
    
    _viewControllers = [NSArray arrayWithObjects:_homeVC, _searchVC, _plusVC, _likesVC, _profileVC, nil];
    
    self.buttonName = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"homeUI.png"],
                       [UIImage imageNamed:@"searchUI.png"],
                       [UIImage imageNamed:@"addPostUI.png"],
                       [UIImage imageNamed:@"likeUI.png"],
                       [UIImage imageNamed:@"profileUI.png"],
                       nil];
    
    self.tappedButtonName = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"tapHomeUI.png"],
                             [UIImage imageNamed:@"tapSearchUI.png"],
                             [UIImage imageNamed:@"tapAddContentUI.png"],
                             [UIImage imageNamed:@"tapLikesUI.png"],
                             [UIImage imageNamed:@"tapProfile.png"],
                             nil];
    
    //активный вью
    _selectedIndex = 0;
    _previousIndex = _selectedIndex;
    
    //пушим вью в главный
    UIViewController * currentVC = _viewControllers[_selectedIndex];
    [self addChildViewController:currentVC];
    currentVC.view.frame = _contentViewController.bounds;
    [_contentViewController addSubview:currentVC.view];
    [currentVC didMoveToParentViewController:self];
    
    //тапаем активную кнопку на tap bar меню
    NSArray *allButtons = [NSArray arrayWithObjects:_tbHome,_tbSearch,_tbPlus,_tbLikes,_tbProfile, nil];
    self.activeButton = allButtons[_selectedIndex];
    [self.activeButton setImage:self.tappedButtonName[_previousIndex] forState:UIControlStateNormal];
    
}

- (IBAction)didPressTab:(UIButton *)sender;
{
    
    //меняем картинку прошлой кнопки на НЕ тапнутую
    [self.activeButton setImage:self.buttonName[_previousIndex] forState:UIControlStateNormal];
    
    //удаляем прошлый контроллер
    UIViewController * previousVC = _viewControllers[_previousIndex];
    [previousVC willMoveToParentViewController:nil];
    [previousVC.view removeFromSuperview];
    [previousVC removeFromParentViewController];
    
    _selectedIndex = [sender.restorationIdentifier intValue];
    
    //меняем картинку тапнутой кнопки на тапнутую
    [sender setImage:self.tappedButtonName[_selectedIndex] forState:UIControlStateNormal];
    
    //запускаем новый контроллер
    UIViewController * currentVC = _viewControllers[_selectedIndex];
    [self addChildViewController:currentVC];
    currentVC.view.frame = _contentViewController.bounds;
    [_contentViewController addSubview:currentVC.view];
    [currentVC didMoveToParentViewController:self];
    
    _previousIndex = _selectedIndex;
    
    //сохраняем кнопку на следующий раз
    self.activeButton = sender;
    
}


@end
