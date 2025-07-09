Class {
	#name : 'ConfigurationOfRefsHunter',
	#superclass : 'Object',
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : 'ConfigurationOfRefsHunter',
	#package : 'ConfigurationOfRefsHunter'
}

{ #category : 'development support' }
ConfigurationOfRefsHunter class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>
]

{ #category : 'private' }
ConfigurationOfRefsHunter class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #'ConfigurationOf'
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #'ConfigurationOf' ifAbsent: aBlock ].
]

{ #category : 'catalog' }
ConfigurationOfRefsHunter class >> catalogContactInfo [
	^ 'pavel.krivanek@gmail.com'
]

{ #category : 'catalog' }
ConfigurationOfRefsHunter class >> catalogDescription [
	^ 'RefsHunter is a small tool that creates a temporary snapshot of the object memory and then uses it for investigation of strong references between different objects in an efficient way.'
]

{ #category : 'catalog' }
ConfigurationOfRefsHunter class >> catalogKeywords [
	^ #(memory leaks pointers references)
]

{ #category : 'private' }
ConfigurationOfRefsHunter class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : 'private' }
ConfigurationOfRefsHunter class >> ensureMetacelloBaseConfiguration [
  Smalltalk
    at: #'ConfigurationOf'
    ifAbsent: [ 
      | repository version |
      repository := MCHttpRepository
        location: 'http://smalltalkhub.com/mc/dkh/metacello/main'
        user: ''
        password: ''.
      repository
        versionReaderForFileNamed: 'Metacello-Base-dkh.107'
        do: [ :reader | 
          version := reader version.
          version load.
          version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : 'metacello tool support' }
ConfigurationOfRefsHunter class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : 'loading' }
ConfigurationOfRefsHunter class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : 'loading' }
ConfigurationOfRefsHunter class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : 'loading' }
ConfigurationOfRefsHunter class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : 'accessing' }
ConfigurationOfRefsHunter class >> project [

	^self new project
]

{ #category : 'development support' }
ConfigurationOfRefsHunter class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : 'baselines' }
ConfigurationOfRefsHunter >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/PavelKrivanek/RefsHunter/main/'.
		spec 
			package: 'RefsHunter-Core';
			package: 'RefsHunter-Test'. ].

]

{ #category : 'catalog' }
ConfigurationOfRefsHunter >> catalogContactInfo [
	^ 'pavel.krivanek@gmail.com'
]

{ #category : 'catalog' }
ConfigurationOfRefsHunter >> catalogDescription [
	^ 'RefsHunter is a small tool that creates a temporary snapshot of the object memory and then uses it for investigation of strong references between different objects in an efficient way.'
]

{ #category : 'catalog' }
ConfigurationOfRefsHunter >> catalogKeywords [
	^ #(memory leaks pointers references)
]

{ #category : 'accessing' }
ConfigurationOfRefsHunter >> customProjectAttributes [
    "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

    ^ #()
]

{ #category : 'symbolic versions' }
ConfigurationOfRefsHunter >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.1-baseline'.

]

{ #category : 'accessing' }
ConfigurationOfRefsHunter >> project [
    ^ project
        ifNil: [ 
            "Bootstrap Metacello if it is not already loaded"
            self class ensureMetacello.
            project := MetacelloMCProject new projectAttributes: self customProjectAttributes.	"Create the Metacello project"
            (Smalltalk at: #'MetacelloVersionConstructor') on: self project: project.	"Construct the project"
            project loadType: #'linear'.	"change to #atomic if desired"
            project ]
]

{ #category : 'symbolic versions' }
ConfigurationOfRefsHunter >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.0.2'.

]

{ #category : 'versions' }
ConfigurationOfRefsHunter >> version100: spec [
	<version: '1.0.0' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.0'.
		spec author: 'PavelKrivanek'.
		spec timestamp: '4/7/2016 13:42'.
		spec 
			package: 'RefsHunter-Core' with: 'RefsHunter-Core-PavelKrivanek.1';
			package: 'RefsHunter-Test' with: 'RefsHunter-Test-PavelKrivanek.2'. ].

]

{ #category : 'versions' }
ConfigurationOfRefsHunter >> version101: spec [
	<version: '1.0.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.1'.
		spec author: 'PavelKrivanek'.
		spec timestamp: '4/13/2016 10:39'.
		spec 
			package: 'RefsHunter-Core' with: 'RefsHunter-Core-PavelKrivanek.2';
			package: 'RefsHunter-Test' with: 'RefsHunter-Test-PavelKrivanek.2'. ].

]

{ #category : 'versions' }
ConfigurationOfRefsHunter >> version102: spec [
	<version: '1.0.2' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.2'.
		spec author: 'PavelKrivanek'.
		spec timestamp: '4/14/2016 10:39'.
		spec 
			package: 'RefsHunter-Core' with: 'RefsHunter-Core-PavelKrivanek.4';
			package: 'RefsHunter-Test' with: 'RefsHunter-Test-PavelKrivanek.2'. ].

]
