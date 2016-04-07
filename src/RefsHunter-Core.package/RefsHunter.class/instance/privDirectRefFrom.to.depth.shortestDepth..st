private
privDirectRefFrom: index1 to: index2 depth: depth shortestDepth: shortestDepth

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