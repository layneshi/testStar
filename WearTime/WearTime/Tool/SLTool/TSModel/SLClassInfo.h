//
//  SLClassInfo.h
//
//  Created by ibireme on 15/5/9.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Type encoding's type.
 */
typedef NS_OPTIONS(NSUInteger, SLEncodingType) {
    SLEncodingTypeMask       = 0xFF, ///< mask of type value
    SLEncodingTypeUnknown    = 0, ///< unknown
    SLEncodingTypeVoid       = 1, ///< void
    SLEncodingTypeBool       = 2, ///< bool
    SLEncodingTypeInt8       = 3, ///< char / BOOL
    SLEncodingTypeUInt8      = 4, ///< unsigned char
    SLEncodingTypeInt16      = 5, ///< short
    SLEncodingTypeUInt16     = 6, ///< unsigned short
    SLEncodingTypeInt32      = 7, ///< int
    SLEncodingTypeUInt32     = 8, ///< unsigned int
    SLEncodingTypeInt64      = 9, ///< long long
    SLEncodingTypeUInt64     = 10, ///< unsigned long long
    SLEncodingTypeFloat      = 11, ///< float
    SLEncodingTypeDouble     = 12, ///< double
    SLEncodingTypeLongDouble = 13, ///< long double
    SLEncodingTypeObject     = 14, ///< id
    SLEncodingTypeClass      = 15, ///< Class
    SLEncodingTypeSEL        = 16, ///< SEL
    SLEncodingTypeBlock      = 17, ///< block
    SLEncodingTypePointer    = 18, ///< void*
    SLEncodingTypeStruct     = 19, ///< struct
    SLEncodingTypeUnion      = 20, ///< union
    SLEncodingTypeCString    = 21, ///< char*
    SLEncodingTypeCArray     = 22, ///< char[10] (for example)
    
    SLEncodingTypeQualifierMask   = 0xFF00,   ///< mask of qualifier
    SLEncodingTypeQualifierConst  = 1 << 8,  ///< const
    SLEncodingTypeQualifierIn     = 1 << 9,  ///< in
    SLEncodingTypeQualifierInout  = 1 << 10, ///< inout
    SLEncodingTypeQualifierOut    = 1 << 11, ///< out
    SLEncodingTypeQualifierBycopy = 1 << 12, ///< bycopy
    SLEncodingTypeQualifierByref  = 1 << 13, ///< byref
    SLEncodingTypeQualifierOneway = 1 << 14, ///< oneway
    
    SLEncodingTypePropertyMask         = 0xFF0000, ///< mask of property
    SLEncodingTypePropertyReadonly     = 1 << 16, ///< readonly
    SLEncodingTypePropertyCopy         = 1 << 17, ///< copy
    SLEncodingTypePropertyRetain       = 1 << 18, ///< retain
    SLEncodingTypePropertyNonatomic    = 1 << 19, ///< nonatomic
    SLEncodingTypePropertyWeak         = 1 << 20, ///< weak
    SLEncodingTypePropertyCustomGetter = 1 << 21, ///< getter=
    SLEncodingTypePropertyCustomSetter = 1 << 22, ///< setter=
    SLEncodingTypePropertyDynamic      = 1 << 23, ///< @dynamic
};

/**
 Get the type from a Type-Encoding string.
 
 @discussion See also:
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
 
 @param typeEncoding  A Type-Encoding string.
 @return The encoding type.
 */
SLEncodingType SLEncodingGetType(const char *typeEncoding);


/**
 Instance variable information.
 */
@interface SLClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;              ///< ivar opaque struct
@property (nonatomic, strong, readonly) NSString *name;         ///< Ivar's name
@property (nonatomic, assign, readonly) ptrdiff_t offset;       ///< Ivar's offset
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< Ivar's type encoding
@property (nonatomic, assign, readonly) SLEncodingType type;    ///< Ivar's type

/**
 Creates and returns an ivar info object.
 
 @param ivar ivar opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithIvar:(Ivar)ivar;
@end


/**
 Method information.
 */
@interface SLClassMethodInfo : NSObject
@property (nonatomic, assign, readonly) Method method;                  ///< method opaque struct
@property (nonatomic, strong, readonly) NSString *name;                 ///< method name
@property (nonatomic, assign, readonly) SEL sel;                        ///< method's selector
@property (nonatomic, assign, readonly) IMP imp;                        ///< method's implementation
@property (nonatomic, strong, readonly) NSString *typeEncoding;         ///< method's parameter and return types
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding;   ///< return value's type
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings; ///< array of argumenSL' type

/**
 Creates and returns a method info object.
 
 @param method method opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithMethod:(Method)method;
@end


/**
 Property information.
 */
@interface SLClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly) objc_property_t property; ///< property's opaque struct
@property (nonatomic, strong, readonly) NSString *name;           ///< property's name
@property (nonatomic, assign, readonly) SLEncodingType type;      ///< property's type
@property (nonatomic, strong, readonly) NSString *typeEncoding;   ///< property's encoding value
@property (nonatomic, strong, readonly) NSString *ivarName;       ///< property's ivar name
@property (nullable, nonatomic, assign, readonly) Class cls;      ///< may be nil
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *protocols; ///< may nil
@property (nonatomic, assign, readonly) SEL getter;               ///< getter (nonnull)
@property (nonatomic, assign, readonly) SEL setter;               ///< setter (nonnull)

/**
 Creates and returns a property info object.
 
 @param property property opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithProperty:(objc_property_t)property;
@end


/**
 Class information for a class.
 */
@interface SLClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls; ///< class object
@property (nullable, nonatomic, assign, readonly) Class superCls; ///< super class object
@property (nullable, nonatomic, assign, readonly) Class metaCls;  ///< class's meta class object
@property (nonatomic, readonly) BOOL isMeta; ///< whether this class is meta class
@property (nonatomic, strong, readonly) NSString *name; ///< class name
@property (nullable, nonatomic, strong, readonly) SLClassInfo *superClassInfo; ///< super class's class info
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, SLClassIvarInfo *> *ivarInfos; ///< ivars
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, SLClassMethodInfo *> *methodInfos; ///< methods
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, SLClassPropertyInfo *> *propertyInfos; ///< properties

/**
 If the class is changed (for example: you add a method to this class with
 'class_addMethod()'), you should call this method to refresh the class info cache.
 
 After called this method, `needUpdate` will returns `YES`, and you should call 
 'classInfoWithClass' or 'classInfoWithClassName' to get the updated class info.
 */
- (void)setNeedUpdate;

/**
 If this method returns `YES`, you should stop using this instance and call
 `classInfoWithClass` or `classInfoWithClassName` to get the updated class info.
 
 @return Whether this class info need update.
 */
- (BOOL)needUpdate;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param cls A class.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClass:(Class)cls;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param className A class name.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
