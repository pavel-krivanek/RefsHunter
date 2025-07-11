Class {
	#name : 'BaselineOfRefsHunter',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfRefsHunter',
	#package : 'BaselineOfRefsHunter'
}

{ #category : 'baselines' }
BaselineOfRefsHunter >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec package: 'RefsHunter-Core'.
		spec package: 'RefsHunter-Tests' with: [ spec requires: #('RefsHunter-Core') ].
	
		spec group: 'default' with: #('RefsHunter-Core') ]
]
