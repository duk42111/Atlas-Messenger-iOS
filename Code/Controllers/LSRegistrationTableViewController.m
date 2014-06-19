//
//  LSRegistrationTableViewController.m
//  LayerSample
//
//  Created by Kevin Coleman on 6/10/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//

#import "LSRegistrationTableViewController.h"
#import "LSInputTableViewCell.h"
#import "LSButton.h"
#import "LSAlertView.h"
#import "LSParseController.h"
#import "LSConversationListViewController.h"
#import "LSAppDelegate.h"
#import "LSUserManager.h"

@interface LSRegistrationTableViewController ()

@property (nonatomic, strong) LSButton *registerButton;
@property (nonatomic, strong) LSAlertView *alertView;

@end

@implementation LSRegistrationTableViewController

NSString *const LSRegistrationCellIdentifier = @"registrationCellIdentifier";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.title = @"Register";
        self.accessibilityLabel = @"Register Screen";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeRegisterButton];
    [self configureLayoutConstraints];
    [self.tableView registerClass:[LSInputTableViewCell class] forCellReuseIdentifier:LSRegistrationCellIdentifier];
    self.alertView = [[LSAlertView alloc] init];
}

- (void)initializeRegisterButton
{
    self.registerButton = [[LSButton alloc] initWithText:@"Register"];
    [self.registerButton addTarget:self action:@selector(registerTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];
}

- (void)configureLayoutConstraints
{
    self.registerButton.frame = CGRectMake(0, 0, 280, 60);
    self.registerButton.center = CGPointMake(self.view.center.x, 300);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LSRegistrationCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(LSInputTableViewCell *)cell forIndexPath:(NSIndexPath *)path
{
    switch (path.row) {
        case 0:
            [cell setText:@"Full Name"];
            cell.textField.accessibilityLabel = @"Fullname";
            break;
        case 1:
            [cell setText:@"Username"];
            cell.textField.accessibilityLabel = @"Username";
            break;
        case 2:
            [cell setText:@"Password"];
            cell.textField.secureTextEntry = TRUE;
            cell.textField.accessibilityLabel = @"Password";
            break;
        case 3:
            [cell setText:@"Confirm"];
            cell.textField.secureTextEntry = TRUE;
            cell.textField.accessibilityLabel = @"Confirm";
            break;
        default:
            break;
    }
}

- (void)registerTapped
{
    LSInputTableViewCell *fullNameCell = (LSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    LSInputTableViewCell *usernameCell = (LSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    LSInputTableViewCell *passwordCell = (LSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    LSInputTableViewCell *confirmationCell = (LSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    if([LSUserManager registerWithFullName:fullNameCell.textField.text email:usernameCell.textField.text password:passwordCell.textField.text andConfirmation:confirmationCell.textField.text]) {
        [self.delegate registrationSuccess];
    }
}

@end