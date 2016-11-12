//
//  ViewController.m
//  iOpen2
//
//  Created by Bui Duc Khanh on 11/12/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfDataSend;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openAppURL:(id)sender {
    // Opens the Receiver app if installed, otherwise displays an error
    UIApplication *ourApplication = [UIApplication sharedApplication];
    
    NSString *URLEncodedText = [self.tfDataSend.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *ourPath = [@"iOpen://" stringByAppendingString:URLEncodedText];
    NSLog(@"%@", ourPath);
    NSURL *ourURL = [NSURL URLWithString:ourPath];
    
    if ([ourApplication canOpenURL:ourURL]) {
        [ourApplication openURL:ourURL
                        options:@{}
              completionHandler:nil];
    }
    else {
        //Display error
        UIAlertController * warningAlert = [UIAlertController
                                            alertControllerWithTitle:@"Thông báo"
                                            message:@"Không tìm thấy app tương ứng với URL"
                                            preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle your yes please button action here
                                   }];
        
        [warningAlert addAction:okButton];
        
        [self presentViewController:warningAlert animated:YES completion:nil];
    }
}



@end
