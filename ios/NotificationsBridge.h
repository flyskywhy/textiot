#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#elif __has_include("RCTBridgeModule.h")
#import “RCTBridgeModule.h”
#else
#import "React/RCTBridgeModule.h"
#endif

#import <React/RCTBridge.h>

@interface NotificationsBridge : NSObject <RCTBridgeModule>

@end

@interface RCTBridge (NotificationsBridge)

@property (nonatomic, readonly) NotificationsBridge *notificationsBridge;

@end
