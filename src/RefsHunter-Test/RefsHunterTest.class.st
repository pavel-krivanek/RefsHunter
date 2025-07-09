"
Test RefsHunter functionality.

WARNING:  very time and memory demanding test case
"
Class {
	#name : 'RefsHunterTest',
	#superclass : 'TestCase',
	#category : 'RefsHunter-Test',
	#package : 'RefsHunter-Test'
}

{ #category : 'testing' }
RefsHunterTest >> testWayFromTo [

	| rh o1 o2 o3 o4 o5 o6 |
	o1 := Object new.
	o2 := Object new.
	o3 := (o1 -> o2).
	o4 := (#key -> o3).
	o5 := Array with: o4 with: o4.
	o6 := Array with: o4 with: o3.
	
	rh := RefsHunter snapshot.
	
	self assert: ((rh wayFrom: o1 to: o1) size = 1).
	self assert: ((rh wayFrom: o1 to: o2) isEmpty).
	self assert: ((rh wayFrom: o3 to: o1) isEmpty).
	self assert: ((rh wayFrom: o3 to: o2) isEmpty).
	self assert: ((rh wayFrom: o1 to: o3) size = 2).
	self assert: ((rh wayFrom: o2 to: o3) size = 2).
	self assert: ((rh wayFrom: o1 to: o4) size = 3).
	self assert: ((rh wayFrom: o2 to: o4) size = 3).
	self assert: ((rh wayFrom: o1 to: o5) size = 4).
	self assert: ((rh wayFrom: o1 to: o6) size = 3).
	self assert: ((rh wayFrom: (Array>>#asArray) to: Smalltalk specialObjectsArray) notEmpty).
	
	rh := nil.
	Smalltalk garbageCollect.
]
