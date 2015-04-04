
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@implementation ViewController : UIViewController

-(void) shareTextOnTwitter: (const char *) shareMessage
{
    
    SLComposeViewController *mySLComposerSheet;
    
    NSString *message   = [NSString stringWithUTF8String:shareMessage];
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; //Tell him with what social plattform to use it, e.g. facebook or twitter
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:message,mySLComposerSheet.serviceType]]; //the message you want to post
       
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:mySLComposerSheet animated:YES completion:nil];
        
    }
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                break;
            default:
                break;
        } //check if everything worked properly. Give out a message on the state.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
    
}

-(void) postImageWithMessageOnTwitter: (const char *) path: (const char *) shareMessage
{
    NSString *imagePath = [NSString stringWithUTF8String:path];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    SLComposeViewController *mySLComposerSheet;
    
    NSString *message   = [NSString stringWithUTF8String:shareMessage];
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; //Tell him with what social plattform to use it, e.g. facebook or twitter
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:message,mySLComposerSheet.serviceType]]; //the message you want to post
         [mySLComposerSheet addImage:image];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:mySLComposerSheet animated:YES completion:nil];
        
    }
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                break;
            default:
                break;
        } //check if everything worked properly. Give out a message on the state.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];

}

@end

extern "C"{
    void TwitterTextSharingMethod(const char * message){
        ViewController *vc = [[ViewController alloc] init];
        [vc shareTextOnTwitter: message];
        [vc release];
    }
}

extern "C"{
    void TwitterImageSharing(const char * path, const char * message){
        ViewController *vc = [[ViewController alloc] init];
        [vc postImageWithMessageOnTwitter: path: message];
        [vc release];
    }
}
