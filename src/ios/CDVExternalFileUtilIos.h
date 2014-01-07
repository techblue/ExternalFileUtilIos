#import <Cordova/CDV.h>

@interface CDVExternalFileUtilIos : CDVPlugin <UIDocumentInteractionControllerDelegate> {
    NSString *localFile;
}

- (void) openWith:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) cleanupTempFile: (UIDocumentInteractionController *) controller;

@end
