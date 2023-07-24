//
//  AcessoBioViewController.m
//  AcessoBioReactNative
//
//  Created by Matheus Domingos on 13/07/21.
//

#import "UnicoCheckViewController.h"
#import "UnicoCheckModule.h"
#import <AcessoBio/AcessoBio-Swift.h>
#import "UnicoConfig.h"
#import "UnicoStgConfig.h"

@interface UnicoCheckViewController ()

@end

@implementation UnicoCheckViewController

//documentType = DocumentRGFrente;

- (void)viewDidLoad {
  [super viewDidLoad];

  unicoCheck = [[AcessoBioManager alloc] initWithViewController:self];
  // [unicoCheck setTheme:[[UnicoTheme alloc] init]];

  switch (_mode) {
    case DEFAULT:
      [self performSelector:@selector(callDefaultCamera) withObject:nil afterDelay:0.5];
      break;
    case SMART:
      [self performSelector:@selector(callSmartCamera) withObject:nil afterDelay:0.5];
      break;
  }
}

- (void)callDefaultCamera {
  [unicoCheck setSmartFrame:false];
  [unicoCheck setAutoCapture:false];
//  [unicoCheck setTheme: [UnicoTheme new]];
  [[unicoCheck build] prepareSelfieCamera:self config: [self.env isEqualToString:@"stg"] ? [UnicoStgConfig new] : [UnicoConfig new]];
}

- (void)callSmartCamera {
  [unicoCheck setSmartFrame:true];
  [unicoCheck setAutoCapture:true];
//  [unicoCheck setTheme: [UnicoTheme new]];
  [[unicoCheck build] prepareSelfieCamera:self config: [self.env isEqualToString:@"stg"] ? [UnicoStgConfig new] : [UnicoConfig new]];
}

- (void)onErrorAcessoBioManager:(NSString *)error {
  [self.acessoBioModule onErrorAcessoBioManager:error];
  [self exit];
}

- (void)onCameraReady:(id)cameraOpener {
  [cameraOpener open:self];
}

-(void)onCameraReadyDocument:(id<AcessoBioCameraOpenerDelegate>)cameraOpener  {
  NSLog(@"onCameraReadyDocument");
  [cameraOpener openDocument:DocumentCNHFrente delegate:self];
}

- (void)onCameraFailedDocument:(ErrorBio *)message{
  NSLog(@"onCameraFailedDocument");
  NSLog(@"%@", message.desc);
}

- (void)onCameraFailed:(ErrorBio *)message {
  NSLog(@"onCameraFailed");
  NSLog(@"%@", message.desc);
  [self exit];
}

- (void)onSuccessSelfie:(SelfieResult *)result {
  [self.acessoBioModule onSuccessCamera:result.base64 encoded:result.encrypted];
//  [self.acessoBioModule onSucessCamera: @"Selfie capturada com sucesso"];
  [self exit];
}

- (void)onErrorSelfie:(ErrorBio *)errorBio {
  NSLog(@"onErrorSelfie");
  NSLog(@"%@", errorBio.desc);
  [self exit];
}

- (void)onSuccessDocument: (DocumentResult *)result {
//  [self.acessoBioModule onSucessCamera:result.base64];
//  [self.acessoBioModule onSucessCamera: @"Documento capturado com sucesso"];
  [self exit];
}

- (void)onErrorDocument:(ErrorBio *)errorBio {
  NSLog(@"onErrorDocument");
  NSLog(@"%@", errorBio.desc);
}

- (void)onErrorCameraFace:(NSString *)error {
  NSLog(@"onErrorCameraFace");
  NSLog(@"%@", error);
  [self.acessoBioModule onErrorCameraFace:error];
  [self exit];
}

- (void)onSystemChangedTypeCameraTimeoutFaceInference {
  NSLog(@"onSystemChangedTypeCameraTimeoutFaceInference");
  [self.acessoBioModule systemClosedCameraTimeoutSession];
  [self exit];
}

- (void)onSystemClosedCameraTimeoutSession {
  NSLog(@"onSystemClosedCameraTimeoutSession");
  [self.acessoBioModule systemClosedCameraTimeoutSession];
  [self exit];
}

- (void)onUserClosedCameraManually {
  NSLog(@"onUserClosedCameraManually");
  [self.acessoBioModule userClosedCameraManually];
  [self exit];
}

- (void)exit{
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    [self dismissViewControllerAnimated:YES completion:nil];
  });
}

@end
