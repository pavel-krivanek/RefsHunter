initialization
generateHashDict

	"Generate auxiliary dictionary for faster determination of object indexes."

	hashDict := IdentityDictionary new.
	objects withIndexDo: [ :o :i | 
		hashDict at: o ifAbsentPut: i ]
