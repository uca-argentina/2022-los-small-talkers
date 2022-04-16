Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'length',
		'leaderboard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValid: aLength [
	aLength > 1 ifFalse: [ 
		Error signal: 'Boards need a minimum length of 1' ].
]

{ #category : #'intance creation' }
Board class >> sized: aLength [ 
	self assertValid: aLength.
	^ self new initializeWith: aLength.
]

{ #category : #initialization }
Board >> initializeWith: aLength [ 
	length := aLength.
]

{ #category : #'spaceship registration' }
Board >> registerMultipleSpaceships: aCollectionOfSpaceships [
	aCollectionOfSpaceships do: 
		[:ship |
			leaderboard at: (ship name) put: 0  
		].
]

{ #category : #'spaceship registration' }
Board >> registerSingleSpaceship: aSpaceship [ 
	self registerMultipleSpaceships: { aSpaceship }.
]
