initialization
snapshot
	
	"instantiate and include stacks"
	Stacks := (Process allInstances collect: [:p | (p suspendedContext) ifNotNil: #stack ]) reject: #isNil.

	self collectObjects.
	self generateHashDict.
	self countReferences.

	Stacks := nil.	