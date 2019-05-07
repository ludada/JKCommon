//
//  JKMacros.h
//  JKKit
//
//  Created by Sid on 2018/5/2.
//  Copyright © 2018 Sid. All rights reserved.
//

#ifndef JKMacros_h
#define JKMacros_h

#import <objc/runtime.h>

#define IS_iOS_10_AND_LATER ([UIDevice currentDevice].systemVersion.integerValue >= 10.0)

#define KeyPath(keyPath)\
^NSString *(void) {\
__unused __typeof__(keyPath) x;\
return [@#keyPath substringFromIndex:([@#keyPath rangeOfString:@"." options:NSBackwardsSearch].location + 1)];\
}()


#ifndef JKSYNTH_DYNAMIC_PROPERTY_CTYPE
#define JKSYNTH_DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
_type_ cValue = { 0 }; \
NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
[value getValue:&cValue]; \
return cValue; \
}
#endif

#ifndef JKSYNTH_DYNAMIC_PROPERTY_OBJECT
#define JKSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

#ifdef DEBUG
#define JKLog(formatString, ...) ({ NSLog(formatString, ##__VA_ARGS__); })
#else
#define JKLog(formatString, ...) ({})
#endif

#endif /* JKMacros_h */
