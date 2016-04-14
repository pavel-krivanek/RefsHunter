initialization
countReferences

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
		((obj class isVariable and: [(obj class == CompiledMethod) not]) and: [ obj class isWeak not ]) ifTrue: [
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
		