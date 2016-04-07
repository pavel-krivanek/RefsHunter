Create a temporary snapshot of the object memory and then use it for investigation of strong references between different objects in an efficient way.

WARNING: this tool is very memory demanding

EXAMPLE: 
| rh |
rh := RefsHunter snapshot.
rh wayFrom: (Array>>#asArray) to: Smalltalk specialObjectsArray.