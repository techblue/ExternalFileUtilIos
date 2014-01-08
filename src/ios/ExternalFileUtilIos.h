#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVViewController.h>

@interface ExternalFileUtilIos : CDVPlugin <UIDocumentInteractionControllerDelegate> {
    NSString *localFile;
}

- (void) openWith:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) cleanupTempFile: (UIDocumentInteractionController *) controller;

@end
