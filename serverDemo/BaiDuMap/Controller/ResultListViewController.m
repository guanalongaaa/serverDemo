//
//  ResultListViewController.m
//  serverDemo
//
//  Created by love on 2017/2/22.
//  Copyright © 2017年 love. All rights reserved.
//

#import "ResultListViewController.h"
#import "GALResultCell.h"
@interface ResultListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ResultListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMyTableView];

}

- (void)setResultListArray:(NSArray *)resultListArray{
    if (resultListArray != nil) {
        _resultListArray = nil;
        _resultListArray = resultListArray;
        [self.tableView reloadData];
    }
}

- (void)setMyTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 500, 300) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GALResultCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:self.tableView];
    //    self.view = self.tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (self.resultListArray.count != 0)?(self.resultListArray.count):(0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GALResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[GALResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    GALModel *model = self.resultListArray[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.nameLabel.textColor = [UIColor redColor];
        if (![model.name containsString:@"[当前]"]) {
            model.name = [NSString stringWithFormat:@"[当前]%@",model.name];
        }
        
    }else{
        cell.nameLabel.textColor = [UIColor blackColor];
    }
    cell.model = model;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GALModel *model = self.resultListArray[indexPath.row];
    self.galListBlock(model);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
