testing
testWayFromTo

	| rh o1 o2 o3 |
	o1 := Object new.
	o2 := Object new.
	o3 := (o1 -> o2).
	
	rh := RefsHunter snapshot.
	
	self assert: ((rh wayFrom: o1 to: o1) size = 1).
	self assert: ((rh wayFrom: o1 to: o2) isEmpty).
	self assert: ((rh wayFrom: o3 to: o1) isEmpty).
	self assert: ((rh wayFrom: o3 to: o2) isEmpty).
	self assert: ((rh wayFrom: o1 to: o3) size = 1).
	self assert: ((rh wayFrom: o2 to: o3) size = 1).
	self assert: ((rh wayFrom: o1 to: Smalltalk specialObjectsArray) notEmpty).
	
	rh := nil.
	Smalltalk garbageCollect.