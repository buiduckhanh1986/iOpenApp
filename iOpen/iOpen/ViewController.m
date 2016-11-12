//
//  ViewController.m
//  iOpen
//
//  Created by Bui Duc Khanh on 10/27/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfDataSend;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openApp:(id)sender {
    // Opens the Receiver app if installed, otherwise displays an error
    UIApplication *ourApplication = [UIApplication sharedApplication];
    
    NSString *URLEncodedText = [self.tfDataSend.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *ourPath = [@"iOpen2://" stringByAppendingString:URLEncodedText];
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


/* Mở SMS sử dụng Open App URL */
- (IBAction)openSMS:(id)sender {
    BOOL canOpenURL = [[UIApplication sharedApplication]
                       canOpenURL:[NSURL URLWithString:@"sms://"]];
    
    /*
    if ( canOpenURL ) [[UIApplication sharedApplication]
                       openURL:[NSURL URLWithString:@"sms:+84978158660"]];
     */
    
    if ( canOpenURL )
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms:+84978158660"]
                                           options:@{}
                             completionHandler:nil];
}


/* Mở SMS sử dụng MFMessageComposeViewControllerDelegate */
- (IBAction)openSMSWithHandle:(id)sender {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertController * warningAlert = [UIAlertController
                                      alertControllerWithTitle:@"Lỗi"
                                      message:@"Thiết bị không hỗ trợ SMS"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle your yes please button action here
                                   }];
        
        [warningAlert addAction:okButton];
        
        [self presentViewController:warningAlert animated:YES completion:nil];
        
        return;
    }
    
    NSArray *recipents = @[@"0978158660"];
    NSString *message = [NSString stringWithFormat:@"Nội dung khánh test"];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
        {
            NSLog(@"Cancelled");
            break;
        }
            
        case MessageComposeResultFailed:
        {
            NSLog(@"Failed");
            break;
        }
            
        case MessageComposeResultSent:
        {
            NSLog(@"Sent");
            break;
        }
            
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
