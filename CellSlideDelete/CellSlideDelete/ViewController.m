//
//  ViewController.m
//  CellSlideDelete
//
//  Created by SunnyZhang on 16/11/8.
//  Copyright © 2016年 Sunny. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableTest;
@property(nonatomic,strong) NSMutableArray *arr;

@end

@implementation ViewController

//pragma mark 懒加载初始化table

- (UITableView *)tableTest{
    
    if (!_tableTest) {
        
        _tableTest = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        
        _tableTest.delegate = self;
        
        _tableTest.dataSource =self;
        
    }
    
    return _tableTest;
    
}

#pragma mark 系统方法-didload

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.tableTest.tableFooterView = [[UIView alloc]init];
    
    self.arr = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *arrtemp = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    
    [self.arr addObjectsFromArray:arrtemp];
    
    [self.view addSubview:self.tableTest];
    
}

//2.完成table的代理方法
//
//3.删除操作

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
    
    return cell;
}
#pragma mark 删除行

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    // 先删除模型

    [self.arr removeObjectAtIndex:indexPath.row];

    // 再刷新数据

    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];

}

//4.根据需要 修改默认的delete

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
    
}

//5.当有多个操作按钮时候，类似于QQ上的向左滑动操作

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"+关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        NSLog(@"关注了");

        //收回左侧滑动按钮 并退出编辑

        tableView.editing = NO;

    }];

    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        [self.arr removeObjectAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

        NSLog(@"删除了");

    }];

    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"未读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        tableView.editing = NO;

        NSLog(@"未读");

    }];

    // 改变滑动的背景色 （根据需要修改颜色）

    action0.backgroundColor = [UIColor blueColor];

    action1.backgroundColor = [UIColor orangeColor];

    action2.backgroundColor = [UIColor greenColor];

    return @[action0,action1,action2];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end



