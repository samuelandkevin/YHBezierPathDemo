//
//  ViewController.m
//  UIBezierPathDemo
//
//  Created by YHIOS002 on 17/4/13.
//  Copyright © 2017年 samuelandkevin. All rights reserved.
//

#import "ViewController.h"
#import "DetailVC.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController


#pragma mark - Getter
- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

#pragma mark - Life

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"UIBeizerPathDemo";
    self.navigationController.navigationBar.translucent = NO;
    
    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight  = 60.0f;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    [self.dataArray addObjectsFromArray:@[@"画一个气泡框",@"画一个Loading圈",@"画一条弧线",@"画一条虚线",@"画一个五边形"]];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailVC *vc = [[DetailVC alloc] init];
    vc.row = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
