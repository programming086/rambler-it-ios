// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureMaterialModelObject.m instead.

#import "_LectureMaterialModelObject.h"

@implementation LectureMaterialModelObjectID
@end

@implementation _LectureMaterialModelObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LectureMaterial" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LectureMaterial";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LectureMaterial" inManagedObjectContext:moc_];
}

- (LectureMaterialModelObjectID*)objectID {
	return (LectureMaterialModelObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic lectureMaterialId;

@dynamic link;

@dynamic name;

@dynamic lecture;

@end

@implementation LectureMaterialModelObjectAttributes 
+ (NSString *)lectureMaterialId {
	return @"lectureMaterialId";
}
+ (NSString *)link {
	return @"link";
}
+ (NSString *)name {
	return @"name";
}
@end

@implementation LectureMaterialModelObjectRelationships 
+ (NSString *)lecture {
	return @"lecture";
}
@end
