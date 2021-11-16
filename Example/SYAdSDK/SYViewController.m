//
//  SYViewController.m
//  SYAdSDK
//
//  Created by Thinkman Wang on 01/25/2021.
//  Copyright (c) 2021 Thinkman Wang. All rights reserved.
//

#import "SYViewController.h"

#import <Masonry/Masonry.h>


@interface SYViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SYViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"进入首页");
    
    [self initUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSLog(@"Hello World");
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    
    self.dataArray = @[
        @{@"sectionTitle": @"视煜广告SDK", @"classes": @[
            @{@"title": @"开屏", @"class": @"SYSplashViewController"}
            , @{@"title": @"Banner", @"class": @"SYBannerViewController"}
            , @{@"title": @"插屏", @"class": @"SYInterstitialAdViewController"}
            , @{@"title": @"原生广告", @"class": @"SYExpressViewController"}
        ]},
        @{@"sectionTitle": @"自定义UI", @"classes": @[
            @{@"title": @"Skip按钮", @"class": @"SYSkipButtonController"},
            @{@"title": @"", @"class": @""},
            @{@"title": @"", @"class": @""},
        ]},
        @{@"sectionTitle": @"", @"classes": @[
            @{@"title": @"", @"class": @""},
            @{@"title": @"", @"class": @""},
        ]},
        @{@"sectionTitle": @"综合Demo", @"classes": @[
            @{@"title": @"", @"class": @""},
        ]},
    ];
    
    self.title = @"China Best IOS Demo";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *sectionDic = self.dataArray[section];
    return [sectionDic[@"classes"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *sectionDic = self.dataArray[indexPath.section];
    cell.textLabel.text = sectionDic[@"classes"][indexPath.row][@"title"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *sectionDic = self.dataArray[section];
    return sectionDic[@"sectionTitle"];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *sectionDic = self.dataArray[indexPath.section];
    NSDictionary *dic = sectionDic[@"classes"][indexPath.row];
    Class cls = NSClassFromString(dic[@"class"]);
    id obj = [[cls alloc] init];
    [obj setTitle:dic[@"title"]];
    [self.navigationController pushViewController:obj animated:YES];
}

#pragma mark - Setters/Getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


@end
