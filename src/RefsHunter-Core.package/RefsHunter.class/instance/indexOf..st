accessing
indexOf:  anObject 

	"Return index of anObject int the current snapshot."	

	^ hashDict at: anObject ifAbsent: [ 0 ]
		