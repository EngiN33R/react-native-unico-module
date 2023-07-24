#import "UnicoModule.h"
#import <React/RCTLog.h>
#import "UnicoCheckViewController.h"

@implementation UnicoModule
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(addEvent:(NSString *)name location:(NSString *)location)
{
    RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}

RCT_EXTERN_METHOD(callDefaultCamera:(NSString *)env)
- (void)callDefaultCamera:(NSString *)env {
  [self openCamera:DEFAULT env:env];
}

RCT_EXTERN_METHOD(callSmartCamera:(NSString *)env)
- (void)callSmartCamera:(NSString *)env {
  [self openCamera:SMART env:env];
}

- (void)openCamera: (CameraMode)cameraMode env:(NSString *)env {
  
    dispatch_async(dispatch_get_main_queue(), ^{

        UnicoCheckViewController *unicoView = [UnicoCheckViewController new];

        UIViewController *view = [UIApplication sharedApplication].delegate.window.rootViewController;
        unicoView.viewOrigin = view;
        unicoView.mode = cameraMode;
        unicoView.acessoBioModule = self;
        unicoView.env = env;

        [view presentViewController:unicoView animated:YES completion:nil];

    });
}

// Will be called when this module's first listener is added.
- (void)startObserving {
    hasListeners = YES;
    // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
- (void)stopObserving {
    hasListeners = NO;
    // Remove upstream listeners, stop unnecessary background tasks
}

- (void)onSuccessCamera:(NSString *)base64 encoded:(NSString *)encoded {
    if(hasListeners) {
        [self sendEventWithName:@"onSuccess" body:@{@"base64": base64, @"encoded": encoded}];
    }
}

- (void)onErrorCameraFace:(NSString *)error {
    if(hasListeners) {
        [self sendEventWithName:@"onError" body:@{@"error": @"CAMERA_ERROR", @"raw": error}];
    }
}

- (void)onErrorAcessoBioManager:(NSString *)error {
    if (hasListeners) {
        [self sendEventWithName:@"onError" body:@{@"error": @"UNICO_ERROR", @"raw": error}];
    }
}

- (void)systemClosedCameraTimeoutFaceInference {
    [self sendEventWithName:@"onError" body:@{@"error": @"INFERENCE_TIMEOUT"}];
}

- (void)systemClosedCameraTimeoutSession {
    [self sendEventWithName:@"onError" body:@{@"error": @"SESSION_TIMEOUT"}];
}

- (void)userClosedCameraManually {
    if (hasListeners) {
        [self sendEventWithName:@"onError" body:@{@"error": @"CAMERA_CLOSED_MANUALLY"}];
    }
}

- (void)showAlert{
    UIAlertController *alert = [UIAlertController new];
    alert.title = @"teste";
    alert.message = @"descriptiuon";

    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *view = [UIApplication sharedApplication].delegate.window.rootViewController;
        [view presentViewController:alert animated:YES completion:nil];
    });
}

// MARK: - Supported Events

- (NSArray<NSString *> *)supportedEvents {
  return @[@"onSuccess", @"onError"];
}

@end
