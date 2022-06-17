Class {
	#name : #TrenchRunEventList,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #adding }
TrenchRunEventList >> add: event [

	events add: event
]

{ #category : #initialization }
TrenchRunEventList >> initialize [
	
	super initialize.
	events := OrderedCollection new.
	
]

{ #category : #accessing }
TrenchRunEventList >> lastEvent [

	events isEmpty ifTrue: [ 
		Error signal:
			'Trying to access last event when no previous event happened' ].
	^ events last.
]

{ #category : #initialization }
TrenchRunEventList >> lastLandsOnSquareEvent [

	| landsOnSquareEvents |
	landsOnSquareEvents := events select: [ :event | 
		                       event className match: 'LandsOnSquareEvent' ].
	landsOnSquareEvents ifEmpty: [ 
		Error signal:
			'Trying to access last lands on square event when none ever happened' ].
	^ landsOnSquareEvents last
]

{ #category : #initialization }
TrenchRunEventList >> lastPlayCardEvent [

	| playCardEvents |
	playCardEvents := events select: [ :event | 
		                  event className match: 'PlayCardEvent' ].
	playCardEvents ifEmpty: [ 
		Error signal:
			'Trying to access last played card event when none ever happened' ].
	^ playCardEvents last
]
