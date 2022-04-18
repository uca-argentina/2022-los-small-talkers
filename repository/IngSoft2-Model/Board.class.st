Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'length',
		'leaderboard',
		'game'
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

{ #category : #'intance creation' }
Board class >> sized: aLength withSpaceships: aCollectionOfSpaceships [
	self assertValid: aLength.
	^ self new initializeSized: aLength withSpaceships: aCollectionOfSpaceships.
]

{ #category : #adding }
Board >> addSpaceships: aCollectionOfSpaceships [
	
	aCollectionOfSpaceships do: [:ship |
		leaderboard at: (ship name) put: 1.
	].
]

{ #category : #initialization }
Board >> associateToGame: aGameInstance [ 
	game := aGameInstance.
]

{ #category : #initialization }
Board >> initializeSized: aLength withSpaceships: aCollectionOfSpaceships [

	length := aLength.
	leaderboard := Dictionary new.
	aCollectionOfSpaceships do: [ :ship |
		 leaderboard at: (ship name) put: 1.
	].
	
]

{ #category : #initialization }
Board >> initializeWith: aLength [ 
	length := aLength.
	leaderboard := Dictionary new.
]

{ #category : #'spaceship position related' }
Board >> move: aShip forwardSquares: numberOfSquaresForward [
	
	|shipPosition|
	
	numberOfSquaresForward < 0 ifTrue: [ 
		 Error signal: 'Cannot move forward negative squares'.
	].
	
	shipPosition := (self positionOf: aShip) + numberOfSquaresForward .
	
	shipPosition >= length ifTrue: [ 
		leaderboard at: (aShip name) put: length.
		game end.
	] ifFalse: [ 
		leaderboard at: (aShip name) put: numberOfSquaresForward.
	]
]

{ #category : #'spaceship position related' }
Board >> positionOf: aShip [
	
	|position|
	position := leaderboard at: (aShip name) ifAbsent: [ 
		 Error signal: 'Cannot get position of unregistered spaceship'.
	].
	
	^position.
]
