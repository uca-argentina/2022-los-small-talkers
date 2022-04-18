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
	^ self new initializeWithShips: { aSpaceship } diceCup: aDiceCup board: aBoard. 
]

{ #category : #'instance creation' }
GameInstance class >> withSpaceships: aCollectionOfSpaceships diceCup: aDiceCup board: aBoard [ 
	^ self new initializeWithShips: aCollectionOfSpaceships diceCup: aDiceCup board: aBoard. 
]

{ #category : #initialization }
GameInstance >> associateGameInstanceToShips: aCollectionOfShips [
	|game|
	game := self.
	
	aCollectionOfShips do: [ :ship | ship associateToGame: game ].
]

{ #category : #initialization }
GameInstance >> associateOwnGameBoardWith: aBoard [
	gameBoard := aBoard.
	gameBoard associateToGame: self
]

{ #category : #accessing }
GameInstance >> end [
	state := GameStateFinished new.
]

{ #category : #initialization }
GameInstance >> initializeWithBoard: aBoard [
	"only for testing Board-GameInstance interaction purposes"

	gameBoard := aBoard.
	aBoard associateToGame: self.
]

{ #category : #initialization }
GameInstance >> initializeWithShips: aCollectionOfSpaceships diceCup: aDiceCup board: aBoard [
	self associateOwnGameBoardWith: aBoard.
	dice := aDiceCup.
	state := GameStateNotStarted new.
	gameBoard addSpaceships: aCollectionOfSpaceships.
	self associateGameInstanceToShips: aCollectionOfSpaceships.
]

{ #category : #printing }
GameInstance >> printState [
	^ state printState.
]

{ #category : #accessing }
GameInstance >> winner [
  ^(gameBoard spaceshipAt: (gameBoard length)).
]

{ #category : #'game starting' }
GameInstance >> start [
	state := GameStateStarted new.
]

{ #category : #'game starting' }
GameInstance >> startAutomatedMatch [
  self shouldBeImplemented.
]

{ #category : #'turn related' }
GameInstance >> startTurn: ship [
	|diceRollResult|
	
	((dice isNil) or: (gameBoard isNil)) ifTrue: [ 
		 Error signal: 'Cannot start a game without board or dice'.
	].
	
	state update: self.
	
	diceRollResult := dice roll.
	
	gameBoard move: ship forwardSquares: diceRollResult.
]
