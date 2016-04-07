accessing
wayFrom: obj1 to: obj2

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
	