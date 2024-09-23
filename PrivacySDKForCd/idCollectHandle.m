//
//  idCollectHandle.m
//  privacySDK
//
//  Created by chendan on 2024/5/30.
//

#import "idCollectHandle.h"
#import <objc/runtime.h>

@implementation idCollectHandle

static NSUUID *_idfv;
static NSUUID *_idfa;

+ (BOOL)swizzleOriginMethod:(SEL)originalSEL withAlternateMethod:(SEL)alternateSEL {
    
    Method originalMethod = class_getInstanceMethod(self, originalSEL);
    if (!originalMethod) {
        return NO;
    }
    
    Method alternateMethod = class_getInstanceMethod(self, alternateSEL);
    if (!alternateMethod) {
        return NO;
    }
    
    method_exchangeImplementations(originalMethod, alternateMethod);
    
    return YES;
}

-(void)handle
{
    Class IDFV_class = NSClassFromString(@"UIDevice");
    SEL IDFV_sel = NSSelectorFromString(@"identifierForVendor");
    
    if(IDFV_class &&  IDFV_sel)
    {
        Method originalMethod_IDFV = class_getInstanceMethod(IDFV_class, IDFV_sel);
        
        Method jf_identifierForVendor = class_getInstanceMethod([self class], @selector(jf_identifierForVendor));
        
        if(originalMethod_IDFV && jf_identifierForVendor)
        {
            class_addMethod(IDFV_class, @selector(jf_identifierForVendor), method_getImplementation(originalMethod_IDFV), method_getTypeEncoding(originalMethod_IDFV));
                
            class_addMethod(IDFV_class, IDFV_sel, method_getImplementation(jf_identifierForVendor), method_getTypeEncoding(jf_identifierForVendor));
                
            method_exchangeImplementations(originalMethod_IDFV, jf_identifierForVendor);
        }
    }
    
    Class IDFA_class = NSClassFromString(@"ASIdentifierManager");
    SEL IDFA_sel = NSSelectorFromString(@"advertisingIdentifier");
    if(IDFA_class && IDFA_sel)
    {
        Method originalMethod_IDFA = class_getInstanceMethod(IDFA_class, IDFA_sel);
        
        Method jf_advertisingIdentifier = class_getInstanceMethod([self class], @selector(jf_advertisingIdentifier));
        if(originalMethod_IDFA && jf_advertisingIdentifier)
        {
            class_addMethod(IDFA_class, @selector(jf_advertisingIdentifier), method_getImplementation(originalMethod_IDFA), method_getTypeEncoding(originalMethod_IDFA));
                
            class_addMethod(IDFA_class, IDFA_sel, method_getImplementation(jf_advertisingIdentifier), method_getTypeEncoding(jf_advertisingIdentifier));
                
            method_exchangeImplementations(originalMethod_IDFA, jf_advertisingIdentifier);
        }
    }
}

- (NSUUID *)jf_identifierForVendor {
    if(_idfv == nil) {
        _idfv = [self jf_identifierForVendor];
    }
    return _idfv;
}

- (NSUUID *)jf_advertisingIdentifier {
    if(_idfa == nil) {
        _idfa = [self jf_advertisingIdentifier];
    }
    return _idfa;
}

@end
