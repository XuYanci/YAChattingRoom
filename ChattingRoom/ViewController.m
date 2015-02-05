//
//  ViewController.m
//  ChattingRoom
//
//  Created by wind on 4/28/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "ViewController.h"
#import "YAChattingDialog.h"

 #import "YAGroupChattingViewController.h"
 @interface ViewController ()

@end

@implementation ViewController
 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Config TextField
    // Config TextView
    // Config WebView
 

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)YAGroupChatting:(id)sender {
    YAGroupChattingViewController *groupChattingViewController = [[YAGroupChattingViewController alloc]init];
    [self.navigationController pushViewController:groupChattingViewController animated:true];
    
}

 
@end
