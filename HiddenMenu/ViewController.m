//
//  ViewController.m
//  HiddenMenu
//
//  Created by Divan Visagie on 2012/09/23.
//  Copyright (c) 2012 Divan Visagie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong,nonatomic) NSArray *menuArray; //array for menu

-(void)showMenu;
-(void)hideMenu;

@end

@implementation ViewController

@synthesize menuArray,
            menuTable,
            content,
            contentNavBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Find the path for the menu resource and load it into the menu array
    NSString *menuPlistPath = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
    
    menuArray = [[NSArray alloc] initWithContentsOfFile:menuPlistPath];
    
    //add some gestures
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return menuArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    NSDictionary *menuItem = [menuArray objectAtIndex:indexPath.row];
    cell.textLabel.text = menuItem[@"Title"]; /* Note , this is new objective c functionality , 
                                               for older versions use [menuItem objectForKey:@"Title"];*/
    cell.detailTextLabel.text = menuItem[@"Subtitle"];
    
    
    return cell;
}


#pragma mark - UITableView Delegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    contentNavBar.topItem.title = menuArray[indexPath.row][@"Title"]; /*I went wild with the new 
                                                                       syntax on this one*/
}


#pragma mark - Actions -
- (IBAction)showMenuDown:(id)sender {
    
    if(content.frame.origin.x == 0) //only show the menu if it is not already shown
        [self showMenu];
    else
        [self hideMenu];
    
}


#pragma mark - animations -
-(void)showMenu{
    
    //slide the content view to the right to reveal the menu 
    [UIView animateWithDuration:.25
             animations:^{
                 
                [content setFrame:CGRectMake(menuTable.frame.size.width, content.frame.origin.y, content.frame.size.width, content.frame.size.height)];
             }
    ];
    
}

-(void)hideMenu{

    //slide the content view to the left to hide the menu
    [UIView animateWithDuration:.25
             animations:^{
        
                 [content setFrame:CGRectMake(0, content.frame.origin.y, content.frame.size.width, content.frame.size.height)];
             }
    ];
}

#pragma mark - Gesture handlers -

-(void)handleSwipeLeft:(UISwipeGestureRecognizer*)recognizer{
    
    if(content.frame.origin.x != 0)
        [self hideMenu];
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer*)recognizer{
    if(content.frame.origin.x == 0)
        [self showMenu];
}

@end
