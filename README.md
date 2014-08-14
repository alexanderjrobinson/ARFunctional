# ARFunctional

ARFunctional is an experiment inspired by "Functional Programming in Swift" to introduce functional programming concepts to NSArray.

## Map

Map creates a new array mapping the objects in the existing array to new objects and adding them to the new array.

```objc

// Map NSNumber values to NSString values
NSArray *testArray = @[@1,@2,@3];
NSArray *newArray = [testArray map:^NSString*(NSNumber* number) {
    return [number stringValue];
}];

// Returns  @[@"1",@"2",@"3"]

```

## Filter

Filter returns a new NSArray containing the entrires that return true for the test block.

```objc

// Filters list for even numbers
NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
NSArray *newArray = [testArray filter:^BOOL(NSNumber *obj) {
    return [obj integerValue] % 2 == 0;
}];

// Returns @[@2,@4,@6]
	
```

## Reject

The opposite of filter, reject returns a new NSArray containing only the entries that return false for the test block.

```objc

// Rejects even numbers
NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
NSArray *newArray = [testArray reject:^BOOL(NSNumber *obj) {
    return [obj integerValue] % 2 == 0;
}];

// Returns @[@1,@3,@5,@7]
	
```

## Any

Returns true if all entries in the array return true for test block.

```objc

// Verify is the list contains any even numbers
NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
BOOL evenNumbers = [testArray any:^BOOL(NSNumber *obj) {
   return [obj integerValue] % 2 == 0;
}];

// Returns YES
	
```

## All

Returns true if all entries in the array return true for test block.

```objc

// Verify if all numbers in the NSArray are positive numbers
NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
BOOL positiveNumbers = [testArray all:^BOOL(NSNumber *obj) {
    return [obj integerValue] > 0;
}];

// Returns YES
	
```

## Chaining Example

Map, Filter and Reject can be chained for more complex scenarios.

```objc

NSArray *cities = @[[[City alloc] initWithName:@"Cincinnati" population:296],
    [[City alloc] initWithName:@"Dayton" population:141],
    [[City alloc] initWithName:@"Columbus" population:787],
    [[City alloc] initWithName:@"Cleveland" population:396]];


NSArray *results = [[[cities map:^City*(City *city) {
   // Cities populations listed in 1,000s
   city.population = city.population * 1000;
   return city;
}] filter:^BOOL(City *city) {
   // Filter cities to only cities with population more than 200,000
   return city.population > 200000;
}] map:^NSString*(City *city) {
   // Map city name to new array of strings
   return city.name;
}];

// Returns @[@"Cincinnati",@"Columbus",@"Cleveland"];
	
```
