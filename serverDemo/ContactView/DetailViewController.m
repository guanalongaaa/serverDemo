//
//  DetailViewController.m
//  serverDemo
//
//  Created by love on 2017/2/15.
//  Copyright © 2017年 love. All rights reserved.
//

#import "DetailViewController.h"
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>

@interface DetailViewController ()


@property (weak, nonatomic) UILabel *firstNameLabel;
@property (weak, nonatomic) UITextField *firstNameField;
@property (weak, nonatomic) UILabel *lastNameLabel;
@property (weak, nonatomic) UITextField *lastNameField;
@property (weak, nonatomic) UILabel *homePhoneLabel;
@property (weak, nonatomic) UITextField *homePhoneField;
@property (weak, nonatomic) UILabel *iPhoneLabel;
@property (weak, nonatomic) UITextField *iPhoneField;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"联系人";
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(delete)];
    
    // Do any additional setup after loading the view.
    [self createUI];
    [self setData];

}

- (void)createUI
{
    UILabel *firstNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 84, 100, 40)];
    firstNameLabel.text = @"姓氏:";
    self.firstNameLabel = firstNameLabel;
    [self.view addSubview:firstNameLabel];
    UITextField *firstNameField = [[UITextField alloc] initWithFrame:CGRectMake(130, 84, self.view.frame.size.width - 230, 40)];
    firstNameField.placeholder = @"如：张";
    self.firstNameField = firstNameField;
    [self.view addSubview:firstNameField];
    
    UILabel *lastNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(firstNameLabel.frame) + 10, 100, 40)];
    lastNameLabel.text = @"名字";
    self.lastNameLabel = lastNameLabel;
    [self.view addSubview:lastNameLabel];
    UITextField *lastNameField = [[UITextField alloc] initWithFrame:CGRectMake(130, CGRectGetMaxY(firstNameLabel.frame) + 10, firstNameField.frame.size.width, 40)];
    lastNameField.placeholder = @"如:三";
    self.lastNameField = lastNameField;
    [self.view addSubview:lastNameField];
    
    UILabel *homePhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(lastNameLabel.frame) + 20, 100, 40)];
    homePhoneLabel.text = @"Home电话:";
    self.homePhoneLabel = homePhoneLabel;
    [self.view addSubview:homePhoneLabel];
    UITextField *homePhoneField = [[UITextField alloc] initWithFrame:CGRectMake(130, CGRectGetMaxY(lastNameLabel.frame) + 20, self.view.frame.size.width - 230, 40)];
    homePhoneField.placeholder = @"如：186-0078-9685";
    self.homePhoneField = homePhoneField;
    [self.view addSubview:homePhoneField];
    
    UILabel *iPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(homePhoneLabel.frame) + 10, 100, 40)];
    iPhoneLabel.text = @"iPhone电话:";
    self.iPhoneLabel = iPhoneLabel;
    [self.view addSubview:iPhoneLabel];
    UITextField *iPhoneField = [[UITextField alloc] initWithFrame:CGRectMake(130, CGRectGetMaxY(homePhoneLabel.frame) + 10, firstNameField.frame.size.width, 40)];
    iPhoneField.placeholder = @"如:186-0078-9685";
    self.iPhoneField = iPhoneField;
    [self.view addSubview:iPhoneField];
    
}
//对获取的联系人信息复制到textField上
- (void)setData
{
    self.firstNameField.text = self.contact.givenName;
    self.lastNameField.text = self.contact.familyName;
    NSArray *phoneArray = self.contact.phoneNumbers;
    for (CNLabeledValue *value in phoneArray) {
        CNPhoneNumber *phone = value.value;
        NSLog(@"%@",value.label);
        if ([value.label rangeOfString:@"Home"].location == NSNotFound) {
            self.homePhoneField.text = phone.stringValue;
        }else{
            self.iPhoneField.text = phone.stringValue;
        }
        
        if ([value.label rangeOfString:@"Work"].location == NSNotFound) {
            self.iPhoneField.text = phone.stringValue;
        }else{
            self.homePhoneField.text = phone.stringValue;
        }

        
        
    }
}

//删除联系人信息
- (void)delete
{
    
    //    CNMutableContact *contact = [[CNMutableContact alloc] init];
    ////    (CNMutableContact *)self.contact;
    //    contact.givenName = self.firstNameField.text;
    //    contact.familyName = self.lastNameField.text;
    //    contact.phoneNumbers = @[[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberHomeFax value:[CNPhoneNumber phoneNumberWithStringValue:self.homePhoneField.text]], [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile value:[CNPhoneNumber phoneNumberWithStringValue:self.iPhoneField.text]]];
    //    self.contact = contact;
    //    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    //    [request updateContact:contact];
    //    CNContactStore *store = [[CNContactStore alloc] init];
//        [store executeSaveRequest:request error:nil];
    
    
//    NSString * identifier = self.contact.identifier;
//    
//    NSArray * arr = [NSArray arrayWithObject:identifier];
//    
//    NSPredicate * predicate = [CNContact predicateForContactsWithIdentifiers:arr];
//    
//    //    NSPredicate * predicate = [CNContact predicateForContactsMatchingName:@"W"];
//    //提取数据
//    NSArray * contacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactIdentifierKey] error:nil];
//    
//    CNMutableContact *contact1 = [contacts objectAtIndex:0];

    
    
    CNContactStore *store = [[CNContactStore alloc] init];
    
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    
    [request deleteContact:self.contact];
    
//    [request deleteContact:[self.contact mutableCopy]];
    
    [store executeSaveRequest:request error:nil];
    
    
    [self.navigationController popViewControllerAnimated:YES];
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
