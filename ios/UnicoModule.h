typedef NS_ENUM(NSInteger, CameraMode) {
  DEFAULT,
  SMART,
//  LIVENESS,
  DOCUMENT_FRONT,
  DOCUMENT_BACK
};

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNUnicoModuleSpec.h"

@interface UnicoModule : NSObject <NativeUnicoModuleSpec> {
#else
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface UnicoModule : RCTEventEmitter<RCTBridgeModule> {
#endif
    bool hasListeners;
}
    
    - (void)onSuccessCamera:(NSString *)base64 encoded:(NSString *)encoded;
    - (void)onErrorCameraFace:(NSString *)error;
    - (void)onErrorAcessoBioManager:(NSString *)error;
    - (void)systemClosedCameraTimeoutFaceInference;
    - (void)systemClosedCameraTimeoutSession;
    - (void)userClosedCameraManually;

@end
