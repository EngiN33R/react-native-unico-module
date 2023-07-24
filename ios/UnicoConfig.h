//
//  UnicoConfig.h
//  UnicoModule
//
//  Created by Ilya Gavrikov on 22.07.23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#ifndef UnicoConfig_h
#define UnicoConfig_h

#import <AcessoBio/AcessoBioManager.h>
#import <AcessoBio/AcessoBio-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnicoConfig : NSObject<AcessoBioConfigDataSource>
@property (assign, nonatomic) NSString *bundleId;
@property (assign, nonatomic) NSString *hostInfo;
@property (assign, nonatomic) NSString *hostKey;
@property (assign, nonatomic) NSString *mobileSdkAppId;
@property (assign, nonatomic) NSString *projectId;
@property (assign, nonatomic) NSString *projectNumber;
@end

NS_ASSUME_NONNULL_END

#endif /* UnicoConfig_h */
