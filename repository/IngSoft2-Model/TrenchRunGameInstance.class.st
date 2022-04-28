Class {
	#name : #TrenchRunGameInstance,
	#superclass : #Object,
	#instVars : [
		'dice',
		'gameBoard',
		'state',
		'positionTracker'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrenchRunGameInstance class >> withParticipating: spaceships rolling: aDiceCup on: aBoard [ 
	^ self new initializeWithParticipating: spaceships rolling: aDiceCup on: aBoard. 
]

{ #category : #initialization }
TrenchRunGameInstance >> associateGameInstanceToShips: aCollectionOfShips [
	|game|
	game := self.
	
	aCollectionOfShips do: [ :ship | ship associateToGame: game ].
]

{ #category : #initialization }
TrenchRunGameInstance >> associateOwnGameBoardWith: aBoard [
	gameBoard := aBoard.
	gameBoard associateToGame: self
]

{ #category : #accessing }
TrenchRunGameInstance >> end [
	state := Finished new.
]

{ #category : #initialization }
TrenchRunGameInstance >> initializeWithParticipating: aCollectionOfSpaceships rolling: aDiceCup on: aBoard [
	self associateOwnGameBoardWith: aBoard.
	dice := aDiceCup.
	state := Started new.
	positionTracker := PositionTracker withSpaceships: aCollectionOfSpaceships.
	self associateGameInstanceToShips: aCollectionOfSpaceships.
]

{ #category : #printing }
TrenchRunGameInstance >> isStarted [
	^ state isStarted.
]

{ #category : #accessing }
TrenchRunGameInstance >> positionTracker [

	^positionTracker.
]

{ #category : #accessing }
TrenchRunGameInstance >> positions [ 

	^positionTracker positions.
]

{ #category : #'game starting' }
TrenchRunGameInstance >> start [
	state := Started new.
]

{ #category : #'game starting' }
TrenchRunGameInstance >> startAutomatedMatch [
	|ships|
	
	ships := positionTracker players.
	[self winner] whileNil: [ 
		ships do: [ :ship |
			(self winner isNil) ifTrue: [ 
				ship startTurn.
			].
		]
	]
	
]

{ #category : #'turn related' }
TrenchRunGameInstance >> startTurn: ship [
	|diceRollResult|
	
	((dice isNil) or: (gameBoard isNil)) ifTrue: [ 
		 Error signal: 'Cannot start a game without board or dice'.
	].
	
	state update: self.
	
	diceRollResult := dice roll.
	
	positionTracker move: ship forwardSquares: diceRollResult then: [ :newPosition | (newPosition >= gameBoard length) ifTrue: [self end]].
]

{ #category : #accessing }
TrenchRunGameInstance >> winner [
  ^state winner: self.
]
