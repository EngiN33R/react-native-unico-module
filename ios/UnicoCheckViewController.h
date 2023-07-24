//
//  UnicoCheckViewController.h
//  UnicoModule
//
//  Created by Ilya Gavrikov on 22.07.23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#ifndef UnicoCheckViewController_h
#define UnicoCheckViewController_h

#import <UIKit/UIKit.h>
#import <AcessoBio/AcessoBioManager.h>
#import <AcessoBio/AcessoBioManagerDelegate.h>
#import "UnicoCheckModule.h"
@class UnicoCheckModule;
NS_ASSUME_NONNULL_BEGIN

@interface UnicoCheckViewController : UIViewController <AcessoBioManagerDelegate,
SelfieCameraDelegate, AcessoBioSelfieDelegate, DocumentCameraDelegate, AcessoBioDocumentDelegate> {
  AcessoBioManager *unicoCheck;
}
@property (strong, nonatomic) UnicoCheckModule *acessoBioModule;
@property (strong, nonatomic) UIViewController *viewOrigin;
@property (assign, nonatomic) CameraMode mode;
@property (assign, nonatomic) NSString *env;

@end

NS_ASSUME_NONNULL_END

#endif /* UnicoCheckViewController_h */
