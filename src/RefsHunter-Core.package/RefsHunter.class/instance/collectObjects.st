initialization
collectObjects

	| count object | 

	Smalltalk garbageCollect.
	
	"get count of all object in the image"
	count := 0.
	object := 0 someObject.
	[object == 0] whileFalse: [
		count := count + 1.
		object := object nextObject ].
	objects := Array new: (count*1.2) asInteger. "create an array for objects that is larger"

	"fill generated array  with the objects"
	count := 0.
	object := 0 someObject.
	[object == 0] whileFalse: [
		object == objects
			ifFalse: [
				count := count + 1.
				objects at: count put: object.].
		object := object nextObject ].
		
	Smalltalk garbageCollect.
	
	"truncate the array"
	objects := objects first: count.