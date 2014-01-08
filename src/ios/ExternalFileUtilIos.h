#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVViewController.h>

@interface ExternalFileUtilIos : CDVPlugin <UIDocumentInteractionControllerDelegate> {
    NSString *localFile;
}

- (void) openWith:(CDVInvokedUrlCommand*)command;
- (void) cleanupTempFile: (UIDocumentInteractionController *) controller;

@end
