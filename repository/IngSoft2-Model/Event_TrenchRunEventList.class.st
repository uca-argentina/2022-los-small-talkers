Class {
	#name : #'Event_TrenchRunEventList',
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #adding }
Event_TrenchRunEventList >> add: event [

	events add: event
]

{ #category : #initialization }
Event_TrenchRunEventList >> initialize [
	
	super initialize.
	events := OrderedCollection new.
	
]

{ #category : #initialization }
Event_TrenchRunEventList >> lastCardIsPlayedEvent [

	| playCardEvents |
	playCardEvents := events select: [ :event | 
		                  event className match: 'Event_CardIsPlayed' ].
	playCardEvents ifEmpty: [ 
		Error signal:
			'Trying to access last played card event when none ever happened' ].
	^ playCardEvents last
]

{ #category : #accessing }
Event_TrenchRunEventList >> lastEvent [

	events isEmpty ifTrue: [ 
		Error signal:
			'Trying to access last event when no previous event happened' ].
	^ events last.
]

{ #category : #initialization }
Event_TrenchRunEventList >> lastLandsOnSquareEvent [

	| landsOnSquareEvents |
	landsOnSquareEvents := events select: [ :event | 
		                       event className match: 'Event_LandsOnSquare' ].
	landsOnSquareEvents ifEmpty: [ 
		Error signal:
			'Trying to access last lands on square event when none ever happened' ].
	^ landsOnSquareEvents last
]
