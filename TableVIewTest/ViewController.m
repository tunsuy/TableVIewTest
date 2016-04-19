//
//  ViewController.m
//  TableVIewTest
//
//  Created by tunsuy on 10/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *uiDataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _uiDataArr = [[NSMutableArray alloc] initWithObjects:@"哈哈哈", @"呵呵呵", @"嘿嘿嘿", @"呢呢呢", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setEditing:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _uiDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.text = _uiDataArr[indexPath.row];
    return cell;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSString *deleteData = _uiDataArr[indexPath.row];
//        [_uiDataArr removeObject:deleteData];
        [_uiDataArr removeObjectAtIndex:indexPath.row];
//        [tableView reloadData];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
        [_uiDataArr insertObject:@"插入的cell" atIndex:indexPath.row];
//        [tableView reloadData];
        
//        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//        [tableView endUpdates];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if (sourceIndexPath.row != destinationIndexPath.row) {
        NSString *moveData = _uiDataArr[sourceIndexPath.row];
//        [_uiDataArr removeObject:moveData];
        [_uiDataArr removeObjectAtIndex:sourceIndexPath.row];
        [_uiDataArr insertObject:moveData atIndex:destinationIndexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//自定义编辑模式的思路
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *editAccesory = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    editAccesory.text = @"ddd";
//    cell.editingAccessoryView = editAccesory;
//    cell.accessoryView = editAccesory;
    
    for (UIView *view in cell.subviews) {
        NSLog(@"cell subviews is : %@", view);
        if ([[[view class] description] isEqualToString:@"UITableViewCellReorderControl"]) {
            [view removeFromSuperview];
        }
    }
    
}

- (NSString *)debugDescription{
    return [NSString stringWithFormat:@"<%@ : %p", [self class],self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
