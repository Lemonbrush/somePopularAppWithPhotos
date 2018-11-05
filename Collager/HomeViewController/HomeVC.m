//
//  HomeVC.m
//  Collager
//
//  Created by Александр on 30.10.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#define TOKEN @"7586268817.25e64f7.e2927214655b4a0ead95d151d6288f71"
#import "UIImageView+AFNetworking.h"
#import "HomeVC.h"
#import "AFNetworking.h"
#import "ContentCell.h"

@interface HomeVC ()
@property NSArray *mainContent;
@property AFHTTPSessionManager *manager;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _manager = [AFHTTPSessionManager manager];
    
    //знак загрузки при свайпе стенки вниз
    _mainTableView.refreshControl = [[UIRefreshControl alloc] init];
    [_mainTableView.refreshControl addTarget:self action: @selector(tableRefresher) forControlEvents:UIControlEventValueChanged];
    
    [self tableRefresher];
    
}

//уменьшай размер лейбла в зависимости от контента в нем *

//обновление таблицы при свайпе
- (void)tableRefresher
{
        [_manager GET:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@&max_id=99&min_id=0&count=50",TOKEN] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
         {
             NSLog(@"%@",responseObject);
             
             self->_mainContent = (NSArray *)responseObject[@"data"];
             [self->_mainTableView reloadData];
             [self->_mainTableView.refreshControl endRefreshing];
             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

//TABLEVIEW/////////////////////////////////////////////////////////////////////////////////////////

//количество ячеек
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{return _mainContent.count;}

//наполнение таблицы
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    //создается ячейка из сториборда
    NSString *cellId = @"contentCell";
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {cell = [[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];}
    
    NSDictionary *contentSection = (NSDictionary *)_mainContent[indexPath.row];
    
    
    NSString *check = contentSection[@"caption"]; //проверка на наличие текста в посте
    
    if([contentSection[@"likes"][@"count"] intValue])[cell.mainTitle setText:[NSString stringWithFormat:@"%@ likes",contentSection[@"likes"][@"count"]]];
    else [cell.mainTitle setText:@""];
    
    if(check != (id)[NSNull null])[cell.comment setText:[NSString stringWithFormat:@"%@",contentSection[@"caption"][@"text"]]];
    else [cell.comment setText:@""];
    
    //добавить счет комментов
    
    [cell.autor setText:[NSString stringWithFormat:@"%@",contentSection[@"user"][@"username"]]];
    
    NSURL *urlProfileImage = [NSURL URLWithString:contentSection[@"user"][@"profile_picture"]];
    NSURL *urlImage = [NSURL URLWithString:contentSection[@"images"][@"standard_resolution"][@"url"]];
    
    
    [cell.contentImage setImageWithURL:urlImage];
    [cell.autorImage setImageWithURL:urlProfileImage];
    
    //маска круга///////////////
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:cell.autorImage.bounds];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    cell.autorImage.layer.mask = maskLayer;
    /////////////////////////////
    
    return cell;
}

//выбор ячейки
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ContentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"Section:%ld Row:%ld selected and its data is %@",
          (long)indexPath.section,(long)indexPath.row,cell.textLabel.text);
}

@end
