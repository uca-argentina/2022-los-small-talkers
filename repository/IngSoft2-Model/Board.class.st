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

{ #category : #'instance creation' }
Board class >> sized: aLength [ 
	self assertValid: aLength.
	^ self new initializeWith: aLength.
]

{ #category : #'test only - instance creation' }
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

{ #category : #'accessing - attributes' }
Board >> getSpaceshipsPositions [

	^leaderboard  
]

{ #category : #'accessing - attributes' }
Board >> getWinner: aCollectionOfSpaceships [
	
	|winnerName|
	winnerName := leaderboard keyAtValue: length.
	^aCollectionOfSpaceships detect: [ :ship | (ship name) match: winnerName ].
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

{ #category : #'accessing - attributes' }
Board >> length [
  ^length.
]

{ #category : #'spaceship position related' }
Board >> move: aShip forwardSquares: numberOfSquaresForward [
	
	|shipPosition|
	
	numberOfSquaresForward < 0 ifTrue: [ 
		 Error signal: 'Cannot move forward negative squares'.
	].
	
	shipPosition := (self positionOfShip: aShip) + numberOfSquaresForward .
	
	shipPosition >= length ifTrue: [ 
		leaderboard at: (aShip name) put: length.
		game end.
	] ifFalse: [ 
		leaderboard at: (aShip name) put: shipPosition .
	]
]

{ #category : #'spaceship position related' }
Board >> positionOfShip: aShip [

	| position |
	position := leaderboard
		            at: (aShip name)
		            ifAbsent: [ 
		            Error signal:
			            'Cannot get position of unregistered spaceship' ].

	^ position
]

{ #category : #'spaceship position related' }
Board >> positionOfShipNamed: aName [

	| position |
	position := leaderboard
		            at: aName
		            ifAbsent: [ 
		            Error signal:
			            'Cannot get position of unregistered spaceship' ].

	^ position
]

{ #category : #'spaceship position related' }
Board >> spaceshipAt: position [
  |shipName|
  shipName := leaderboard keyAtValue: position ifAbsent: [].
  ^shipName.
]
