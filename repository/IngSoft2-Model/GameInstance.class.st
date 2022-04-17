Class {
	#name : #GameInstance,
	#superclass : #Object,
	#instVars : [
		'dice',
		'spaceships',
		'gameBoard',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameInstance class >> board: aBoard [ 
	^self new initializeWithBoard: aBoard. 
]

{ #category : #'instance creation' }
GameInstance class >> withShip: aSpaceship diceCup: aDiceCup board: aBoard [ 
	^ self new initilializeWithShips: { aSpaceship } diceCup: aDiceCup board: aBoard. 
]

{ #category : #'instance creation' }
GameInstance class >> withSpaceships: aCollectionOfSpaceships diceCup: aDiceCup board: aBoard [ 
	^ self new initilializeWithShips: aCollectionOfSpaceships diceCup: aDiceCup board: aBoard. 
]

{ #category : #'as yet unclassified' }
GameInstance >> associateGameInstanceToShips: aCollectionOfShips [
	|game|
	game := self.
	
	aCollectionOfShips do: [ :ship | ship associateGame: game ].
]

{ #category : #accessing }
GameInstance >> end [

	state := GameStateFinished new.
]

{ #category : #initialization }
GameInstance >> initializeWithBoard: aBoard [
	gameBoard := aBoard.
	aBoard associateGame: self.
]

{ #category : #initialization }
GameInstance >> initilializeWithShips: aCollectionOfShips diceCup: aDiceCup board: aBoard [ 
	gameBoard := aBoard.
	gameBoard associateGame: self.
	
	dice := aDiceCup.
	state := GameStateNotStarted new.
	gameBoard addSpaceships: aCollectionOfShips.
	
	self associateGameInstanceToShips: aCollectionOfShips.
	
]

{ #category : #printing }
GameInstance >> printState [

	^ state printState.
]

{ #category : #'game starting' }
GameInstance >> start [
	
	state := GameStateStarted new.
]

{ #category : #'as yet unclassified' }
GameInstance >> startTurn: ship [
	
	|diceRollResult|
	
	state update: self.
	
	diceRollResult := dice roll.
	
	gameBoard move: ship forwardSquares: diceRollResult.
]
