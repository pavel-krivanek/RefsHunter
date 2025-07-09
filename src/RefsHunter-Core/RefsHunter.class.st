"
Create a temporary snapshot of the object memory and then use it for investigation of strong references between different objects in an efficient way.

WARNING: this tool is very memory demanding

EXAMPLE: 
| rh |
rh := RefsHunter snapshot.
rh wayFrom: (Array>>#asArray) to: Smalltalk specialObjectsArray.
"
Class {
	#name : 'RefsHunter',
	#superclass : 'Object',
	#instVars : [
		'objects',
		'references',
		'hashDict',
		'visited'
	],
	#classVars : [
		'Stacks'
	],
	#category : 'RefsHunter-Core',
	#package : 'RefsHunter-Core'
}

{ #category : 'instance creation' }
RefsHunter class >> snapshot [

	^ self new snapshot.
]

{ #category : 'initialization' }
RefsHunter >> collectObjects [

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
]

{ #category : 'initialization' }
RefsHunter >> countReferences [

	"Determine backward references to all objects in the current snapshot."

	| ref |
	
	references := objects collect: [:o | Set new: 10 ].

	objects withIndexDo: [:obj :index |
		"add object class to references"
		"(references at: (self indexOf: obj class)) add: index."
		
		"add object instances"
		1 to: obj class instSize do: [:i |
			ref := obj instVarAt: i.
			((ref class == SmallInteger) 
				| (ref == nil) 
				| (ref == true) 
				| (ref == false)) 
				ifFalse: [
					| ri |
					ri := self indexOf: ref.
					(ri == 0) ifFalse: [(references at: ri) add: index ]]].

		"include variable elements"
		((obj class isVariable and: [(obj class == CompiledMethod) not and: [(obj class == CompiledBlock) not]]) and: [ obj class isWeak not ]) ifTrue: [
			1 to: obj basicSize do: [:i |
				ref := obj basicAt: i.
				((ref class == SmallInteger) 
					| (ref == nil) 
					| (ref == true) 
					| (ref == false)) 
					ifFalse: [
						| ri |
						ri := self indexOf: ref.
						(ri == 0) ifFalse:[(references at: ri) add: index ]]]]]. 
		
]

{ #category : 'initialization' }
RefsHunter >> generateHashDict [

	"Generate auxiliary dictionary for faster determination of object indexes."

	hashDict := IdentityDictionary new.
	objects withIndexDo: [ :o :i | 
		hashDict at: o ifAbsentPut: i ]

]

{ #category : 'accessing' }
RefsHunter >> indexOf:  anObject [ 

	"Return index of anObject int the current snapshot."	

	^ hashDict at: anObject ifAbsent: [ 0 ]
		
]

{ #category : 'initialization' }
RefsHunter >> initialize [

	super initialize.
	

]

{ #category : 'accessing' }
RefsHunter >> objectAt: index [ 
	
	^ objects at: index.
]

{ #category : 'private' }
RefsHunter >> privDirectRefFrom: index1 to: index2 depth: depth shortestDepth: shortestDepth [

	"Recursive determination of a backward references path. Return an association (path->lenght)."

	| refs result paths shortestPath foundDepth | 
	
	result := nil.
	
	(index1 = index2) ifTrue: [ "we have found the object"
		 ^ (OrderedCollection with: index1) -> 0 ].
	
	((visited at: index1) == true) ifTrue: [ "aleready visited (if not, the array contains nil)"
		^ nil -> Float infinity  ].
	visited at: index1 put: true.
	
	shortestDepth < depth ifTrue: [ "we already have a shorter path"
		^ nil -> Float infinity ].
	
	refs := self references at: index1.

	foundDepth := shortestDepth. 
	paths := refs
		 collect: [:ref | "determine all paths from objects pointing to me"
			| assoc |
			assoc := 	self privDirectRefFrom: ref to: index2 depth: depth+1 shortestDepth: foundDepth.
			assoc value < foundDepth ifTrue: [foundDepth := assoc value].
			assoc] 
		thenReject: [:path | "reject paths that do not lead to the second object (with index2)" 
			path key isNil ]. 
	paths ifEmpty: [ "there is no path"
		^ nil->Float infinity ]. 
	
	"select shortest path and return it"
	shortestPath := (paths detectMin: [:path | path value ]). 
	result := ((OrderedCollection with: index1), shortestPath key) -> (shortestPath value+1).
		
	visited at: index1 put: true.
	^ result.
]

{ #category : 'accessing' }
RefsHunter >> references [ 

	^ references
]

{ #category : 'initialization' }
RefsHunter >> snapshot [
	
	"instantiate and include stacks"
	Stacks := ((Process allInstances collect: [:p | (p suspendedContext) ifNotNil: #stack ]) reject: #isNil) asOrderedCollection.
	Stacks add: thisContext stack.

	self collectObjects.
	self generateHashDict.
	self countReferences.

	Stacks := nil.	
]

{ #category : 'accessing' }
RefsHunter >> wayFrom: obj1 to: obj2 [

	"Find shortest path of backward references from obj1 to obj2.
	
	Example:
	rh := RefsHunter snapshot.
	rh wayFrom: (Array>>#asArray) to: Smalltalk specialObjectsArray.
	"

	| i1 i2 result|
	
	i1 := self indexOf: obj1.
	i2 := self indexOf: obj2.
	
	self assert: (i1 ~= 0).
	self assert: (i2 ~= 0).
	
	visited := Array new: objects size.
	
	result := self privDirectRefFrom: i1 to: i2 depth: 1 shortestDepth: Float infinity.

	visited := nil.

	result key ifNil: [ "no path found"
		^ Array new. ]. 
	
	result := result key collect: [:index | (self objectAt: index) ].
	
	^ result.
	
]
