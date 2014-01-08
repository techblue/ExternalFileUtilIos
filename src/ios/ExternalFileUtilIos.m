#import "ExternalFileUtilIos.h"
#import <Cordova/CDVViewController.h>

@implementation ExternalFileUtilIos

- (void) openWith:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult;
    NSString* callbackID = command.callbackId;
    NSArray *arguments = command.arguments;
   
    //[arguments pop];
    [callbackID retain];
    
    NSString *path = [arguments objectAtIndex:0]; 
    [path retain];
    
    NSString *uti = [arguments objectAtIndex:1]; 
    [uti retain]; 
    
    NSLog(@"path %@, uti:%@", path, uti);
    
    NSArray *parts = [path componentsSeparatedByString:@"/"];
    NSString *previewDocumentFileName = [parts lastObject];
    NSLog(@"The file name is %@", previewDocumentFileName);
    
    NSData *fileRemote = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:path]];
    
    // Write file to the Documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory) {NSLog(@"Documents directory not found!");}
    localFile = [documentsDirectory stringByAppendingPathComponent:previewDocumentFileName];
    [localFile retain];
    [fileRemote writeToFile:localFile atomically:YES];
    NSLog(@"Resource file '%@' has been written to the Documents directory from online", previewDocumentFileName);
    
    
    // Get file again from Documents directory
    NSURL *fileURL = [NSURL fileURLWithPath:localFile];
    
    UIDocumentInteractionController *controller = [UIDocumentInteractionController  interactionControllerWithURL:fileURL];
    [controller retain];
    controller.delegate = self;
    controller.UTI = uti;
    
    CDVViewController* cont = (CDVViewController*)[ super viewController ];
    CGRect rect = CGRectMake(0, 0, 1500.0f, 50.0f);
    BOOL isValid = [controller presentOptionsMenuFromRect:rect inView:cont.view animated:YES];
    
    if (!isValid){
         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PDF viewer has not been found"];
    }else{
         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Success"];
    }
    [self writeJavascript: [pluginResult toSuccessCallbackString:callbackID]];
    
    [callbackID release];
    [path release];
    [uti release];
}

- (void) documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    NSLog(@"documentInteractionControllerDidDismissOpenInMenu");
    
    [self cleanupTempFile:controller];
}

- (void) documentInteractionController: (UIDocumentInteractionController *) controller didEndSendingToApplication: (NSString *) application {
    NSLog(@"didEndSendingToApplication: %@", application);
    
    [self cleanupTempFile:controller];
}

- (void) cleanupTempFile: (UIDocumentInteractionController *) controller
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL fileExists = [fileManager fileExistsAtPath:localFile];   
    
    NSLog(@"Path to file: %@", localFile);
    NSLog(@"File exists: %d", fileExists);
    NSLog(@"Is deletable file at path: %d", [fileManager isDeletableFileAtPath:localFile]);
    
    if (fileExists) 
    {
        BOOL success = [fileManager removeItemAtPath:localFile error:&error];
        if (!success) NSLog(@"Error: %@", [error localizedDescription]);
    }
    [localFile release];
    [controller release];
}

@end
