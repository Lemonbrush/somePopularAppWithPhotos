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
@property NSMutableArray *mainContent;
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
             //NSLog(@"%@",responseObject); //---------------------------------
             
             self->_mainContent = (NSMutableArray *)responseObject[@"data"];
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
    
    //берем информацию по посту заданного номера
    NSMutableDictionary *contentSection = (NSMutableDictionary *)_mainContent[indexPath.row];
    
    //cell.likeButton.contentData = contentSection;
    
    NSString *check = contentSection[@"caption"]; //проверка на наличие текста в посте
    
    //количество лайков
    if([contentSection[@"likes"][@"count"] intValue])[cell.mainTitle setText:[NSString stringWithFormat:@"%@ likes",contentSection[@"likes"][@"count"]]];
    else [cell.mainTitle setText:@""];
    
    NSString * nicknameStr = [NSString stringWithFormat:@"%@", contentSection[@"user"][@"username"]];
    
    //текст поста
    if(check != (id)[NSNull null])
    {
        
        NSMutableAttributedString *nickAS = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",nicknameStr]];
        [nickAS addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, nicknameStr.length)];
        
        NSMutableAttributedString *finalContentText  = [[NSMutableAttributedString alloc] initWithString:contentSection[@"caption"][@"text"]];
        
        [nickAS appendAttributedString:finalContentText];
        
        [cell.comment setAttributedTitle:nickAS forState:UIControlStateNormal];
        [cell.comment.titleLabel setNumberOfLines:2];
        
        
    }
    else [cell.comment.titleLabel setText:@""];
    
    //добавить счет комментов
    
    //ник
    [cell.autor setText:nicknameStr];
    
    //картинка поста
    NSURL *urlImage = [NSURL URLWithString:contentSection[@"images"][@"standard_resolution"][@"url"]];
    [cell.contentImage setImageWithURL:urlImage];
    
    //аватарка
    NSURL *urlProfileImage = [NSURL URLWithString:contentSection[@"user"][@"profile_picture"]];
    [cell.autorImage setImageWithURL:urlProfileImage];
    
    //маска круга///////////////
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:cell.autorImage.bounds];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    cell.autorImage.layer.mask = maskLayer;
    /////////////////////////////
    
    UIImage *likeButtonImage;
    if([[NSString stringWithFormat:@"%@",contentSection[@"user_has_liked"]] intValue]){
        likeButtonImage = [UIImage imageNamed:@"activeLikeUI.png"];
        cell.likeButton.liked = 1;
    }
    else
    {
        likeButtonImage = [UIImage imageNamed:@"likeUI.png"];
        cell.likeButton.liked = 0;
    }
    
    [cell.likeButton setImage:likeButtonImage forState:UIControlStateNormal];
    
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
