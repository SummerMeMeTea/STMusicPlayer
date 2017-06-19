//
//  STDiscoveryVC.m
//  STMusicPlayer
//
//  Created by Lan on 2017/6/19.
//  Copyright © 2017年 SummerMeMeTea. All rights reserved.
//

#import "STDiscoveryVC.h"
#import <Masonry/Masonry.h>
#import "STMusicPlayerVC.h"

@interface STDiscoveryVC ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation STDiscoveryVC

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - Private

- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.hidden = NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.dataSource[indexPath.row][@"name"];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    STMusicPlayerVC *vc = [STMusicPlayerVC controller];
    [self.navigationController pushViewController:vc animated:YES];
    [vc playWithList:self.dataSource index:indexPath.row];
}

#pragma mark - Getter

- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = ({
            UITableView *tableview = [UITableView new];
            tableview.dataSource = self;
            tableview.delegate = self;
            tableview.tableFooterView = [UIView new];
            [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
            [self.view addSubview:tableview];
            [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(tableview.superview);
            }];
            tableview;
        });
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = ({
            NSMutableArray *arrayM = [NSMutableArray array];
            [arrayM addObject:@{@"name": @"郭德纲1", @"url": @"http://audio.xmcdn.com/group15/M00/6B/FA/wKgDZVc6yBCjkn7AACdnGevNZjg091.mp3"}];
            [arrayM addObject:@{@"name": @"郭德纲2", @"url": @"http://audio.xmcdn.com/group15/M00/6B/FB/wKgDZVc6yB2RI6FVAPXqCmNNdW0231.mp3"}];
            [arrayM addObject:@{@"name": @"郭德纲3", @"url": @"http://audio.xmcdn.com/group16/M01/6D/9C/wKgDbFc6yAbCHjAUAPMa2x90urI376.mp3"}];
            [arrayM addObject:@{@"name": @"郭德纲4", @"url": @"http://audio.xmcdn.com/group16/M01/6D/88/wKgDalc6x_CSjJyWANvW9DlLtFs823.mp3"}];
            [arrayM addObject:@{@"name": @"郭德纲5", @"url": @"http://audio.xmcdn.com/group14/M00/6E/9E/wKgDZFc6x9jyDFjrAOBM_s0iJcs464.mp3"}];
            [arrayM addObject:@{@"name": @"郭德纲6", @"url": @"http://audio.xmcdn.com/group8/M06/6D/3F/wKgDYFc6x92BuheGAN7fR2fER7U429.mp3"}];
            [arrayM addObject:@{@"name": @"郭德纲7", @"url": @"http://audio.xmcdn.com/group11/M02/78/61/wKgDbVc6x6XyAgKaAOZaYehLvRU118.mp3"}];
            [arrayM addObject:@{@"name": @"郭德纲8", @"url": @"http://audio.xmcdn.com/group13/M01/6D/D4/wKgDXVc6x37DFP-1ANuh5Dacrt4780.mp3"}];
            [arrayM addObject:@{@"name": @"郭德纲9", @"url": @"http://audio.xmcdn.com/group13/M01/6D/D4/wKgDXVc6x4Tx0gJfANu5kBxLUyo956.mp3"}];
            arrayM;
        });
    }
    return _dataSource;
}

@end
