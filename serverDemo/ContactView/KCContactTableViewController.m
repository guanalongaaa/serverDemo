//
//  KCContactTableViewController.m
//  serverDemo
//
//  Created by love on 2017/2/13.
//  Copyright © 2017年 love. All rights reserved.
//

#import "KCContactTableViewController.h"
#import <Contacts/Contacts.h>
#import "DetailViewController.h"
#import "KCAddPersonViewController.h"

@interface KCContactTableViewController ()<KCContactDelegate>

//@property (assign, nonatomic) ABAddressBookRef addressBook;
@property (assign, nonatomic) CNContactStore * addressBook;

@property (strong,nonatomic) NSMutableArray *allPerson;//通讯录所有人员

@property (assign,nonatomic) int isModify;//标识是修改还是新增，通过选择cell进行导航则认为是修改，否则视为新增
@property (assign,nonatomic) UITableViewCell *selectedCell;//当前选中的单元格


@end

@implementation KCContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addItem)];
    
    self.title = @"通讯录";
    
    UIBarButtonItem * backBar = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backItem)];
    UIBarButtonItem * eidt = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editItem)];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:backBar,eidt, nil];

    
    self.allPerson = [NSMutableArray array];

//    //请求访问通讯录并初始化数据
//    [self requestAddressBook];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //请求访问通讯录并初始化数据
    [self requestAddressBook];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allPerson.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identtityKey=@"myTableViewCellIdentityKey1";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identtityKey];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identtityKey];
    }
    
    CNContact *contact = self.allPerson[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *givenName = contact.givenName;
    NSString *familyName = contact.familyName;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",givenName,familyName];
    return cell;

    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        ABRecordRef recordRef=(__bridge ABRecordRef )self.allPerson[indexPath.row];
//        [self removePersonWithRecord:recordRef];//从通讯录删除
        [self.allPerson removeObjectAtIndex:indexPath.row];//从数组移除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];//从列表删除
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    self.isModify=1;
    self.selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    
    CNMutableContact *contact = [self.allPerson[indexPath.row] mutableCopy];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.contact = contact;
    [self.navigationController pushViewController:detail animated:YES];

}




#pragma mark - KCContact代理方法
-(void)editPersonWithFirstName:(NSString *)firstName lastName:(NSString *)lastName workNumber:(NSString *)workNumber{
//    if (self.isModify) {
//        UITableViewCell *cell=self.selectedCell;
//        NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
//        [self modifyPersonWithRecordID:(ABRecordID)cell.tag firstName:firstName lastName:lastName workNumber:workNumber];
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
//    }else{
//        [self addPersonWithFirstName:firstName lastName:lastName workNumber:workNumber];//通讯簿中添加信息
//        [self initAllPerson];//重新初始化数据
//        [self.tableView reloadData];
//    }
    self.isModify=0;
}
-(void)cancelEdit{
    self.isModify=0;
}





#pragma mark - 私有方法
/** * 请求访问通讯录 */
-(void)requestAddressBook{
    //创建通讯录对象
//    self.addressBook=ABAddressBookCreateWithOptions(NULL, NULL);
    
    CNContactStore *store = [[CNContactStore alloc] init];
    
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"未获得通讯录访问权限！");
        }
        [self initAllPerson];

    }];
    
}

/** * 取得所有通讯录记录 */
-(void)initAllPerson{
    //取得通讯录访问授权
//    ABAuthorizationStatus authorization= ABAddressBookGetAuthorizationStatus();
    
    CNAuthorizationStatus authorization = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    //如果未获得授权
    if (authorization!=CNAuthorizationStatusAuthorized) {
        NSLog(@"尚未获得通讯录访问授权！");
        return ;
    }
    //取得通讯录中所有人员记录
    
    [self.allPerson removeAllObjects];
    
    CNContactStore *stroe = [[CNContactStore alloc] init];
    NSArray *keys = @[CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];

    [stroe enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        [self.allPerson addObject:contact];
       
        [self.tableView reloadData];
    }];
    
}






-(void)editItem
{
    self.tableView.editing=!self.tableView.editing;
}

- (void)backItem{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addItem{
    KCAddPersonViewController * control = [[KCAddPersonViewController alloc]init];
    
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:control];
//    [self presentViewController:navigationController animated:YES completion:nil];
//
//    [self presentViewController:control animated:YES completion:nil];
    
    [self.navigationController pushViewController:control animated:YES];
}

@end
