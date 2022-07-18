Class {
	#name : #TurnHandler,
	#superclass : #Object,
	#instVars : [
		'spaceshipTurnSequence',
		'turnSkips'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
TurnHandler class >> withParticipating: spaceships [

	spaceships ifEmpty: [ 
		Error signal:
			'Game cannot be created with no participating spaceships' ].
		
	^ self new initializeWithParticipating: spaceships.
]

{ #category : #'accessing current spaceship turn' }
TurnHandler >> currentSpaceshipTurn [

	^ spaceshipTurnSequence current
]

{ #category : #initialization }
TurnHandler >> initializeWithParticipating: spaceships [

	spaceshipTurnSequence := TrenchRunSequence withAll: spaceships.
	turnSkips := Dictionary
		             newFromKeys: spaceships
		             andValues: (spaceships collect: [ :bar | 0 ])
]

{ #category : #'next turn' }
TurnHandler >> nextSpaceshipTurn [

	| nextSpaceship turnsSkippedOfSpaceship|
	nextSpaceship := spaceshipTurnSequence next.
	turnsSkippedOfSpaceship := turnSkips at: nextSpaceship.
	turnsSkippedOfSpaceship > 0 ifTrue: [ 
		turnSkips at: nextSpaceship put: turnsSkippedOfSpaceship - 1.
		^ self nextSpaceshipTurn
	].
	^ nextSpaceship
]

{ #category : #'alter order of turns' }
TurnHandler >> repeatTurn [

	spaceshipTurnSequence repeatLastOnNext.
]

{ #category : #'alter order of turns' }
TurnHandler >> reverseOrderOfTurns [
	
	spaceshipTurnSequence := spaceshipTurnSequence reversed.
	
]

{ #category : #'turn skipping' }
TurnHandler >> skip: anAmountOfTurns of: someSpaceship [

	| currentSkips |
	currentSkips := turnSkips
		                at: someSpaceship
		                ifAbsent: [ 
		                Error signal:
			                'Cannot skip turns of non participating spaceships' ].
	turnSkips at: someSpaceship put: currentSkips + anAmountOfTurns.
]
