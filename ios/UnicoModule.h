
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNUnicoModuleSpec.h"

@interface UnicoModule : NSObject <NativeUnicoModuleSpec>
#else
#import <React/RCTBridgeModule.h>

@interface UnicoModule : NSObject <RCTBridgeModule>
#endif

@end
