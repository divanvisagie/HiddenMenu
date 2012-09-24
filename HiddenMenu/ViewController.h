//
//  ViewController.h
//  HiddenMenu
//
//  Created by Divan Visagie on 2012/09/23.
//  Copyright (c) 2012 Divan Visagie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, nonatomic) IBOutlet UIView *content;

@property (weak, nonatomic) IBOutlet UINavigationBar *contentNavBar;
- (IBAction)showMenuDown:(id)sender;


@end
