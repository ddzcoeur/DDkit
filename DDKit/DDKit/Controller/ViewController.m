//
//  ViewController.m
//  DDKit
//
//  Created by Ayasofya on 16/1/6.
//  Copyright (c) 2016 ddz. All rights reserved.
//


#import "ViewController.h"
#import "DDNetworkProxy.h"
#import "DDChatCell.h"
#import "DDMessageBase.h"


@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) UITextField *inputView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSString *urlStr = @"ws://localhost:9000/chat";
    [[DDNetworkProxy getInstance] setUrl:urlStr];
    [[DDNetworkProxy getInstance] connect];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.frame;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"chatCell";
    DDMessageBase *msg = [self.messages objectAtIndex:indexPath.row];
    DDChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell){
        cell = [[DDChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateCell:msg.message];
    return cell;
}

#pragma mark -tableview delegate


#pragma mark -netproxy


@end