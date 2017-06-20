//
//  KCAddPersonViewController.m
//  serverDemo
//
//  Created by love on 2017/2/14.
//  Copyright © 2017年 love. All rights reserved.
//

#import "KCAddPersonViewController.h"

#import "KCContactTableViewController.h"
#import <Contacts/Contacts.h>

@interface KCAddPersonViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *workPhone;
@property (weak, nonatomic) IBOutlet UITextField *iphoneNum;



@end

@implementation KCAddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self setupUI];
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(backItem)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(SaveItem)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 私有方法
-(void)setupUI{
    if (self.recordID) {//如果ID不为0则认为是修改，此时需要初始化界面
        self.firstName.text=self.firstNameText;
        self.lastName.text=self.lastNameText;
        self.workPhone.text=self.workPhoneText;
    }
}

-(void)SaveItem{
    
    CNMutableContact *contact = [[CNMutableContact alloc] init];
    contact.givenName = self.firstName.text;
    contact.familyName = self.lastName.text;
    contact.phoneNumbers = @[[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberHomeFax value:[CNPhoneNumber phoneNumberWithStringValue:self.workPhone.text]], [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile value:[CNPhoneNumber phoneNumberWithStringValue:self.iphoneNum.text]]];
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    [request addContact:contact toContainerWithIdentifier:nil];
    CNContactStore *store = [[CNContactStore alloc] init];
    [store executeSaveRequest:request error:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)backItem{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
