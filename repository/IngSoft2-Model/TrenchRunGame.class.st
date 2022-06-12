Class {
	#name : #TrenchRunGame,
	#superclass : #Object,
	#instVars : [
		'dice',
		'gameBoard',
		'state',
		'positionTracker',
		'sequence',
		'endingLap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrenchRunGame class >> withParticipating: spaceships rolling: aDiceCup on: aBoard until: endLap [

	^ self new
		  initializeWithParticipating: spaceships
		  rolling: aDiceCup
		  on: aBoard
		  until: endLap
]

{ #category : #'accessing - positions' }
TrenchRunGame >> currentLeader [

	^ positionTracker currentLeader
]

{ #category : #private }
TrenchRunGame >> end [
	state := Finished new.
]

{ #category : #initialization }
TrenchRunGame >> initializeWithParticipating: spaceships rolling: aDiceCup on: aBoard until: endLap [

	gameBoard := aBoard.
	dice := aDiceCup.
	state := Started new.
	endingLap := endLap.
	positionTracker := PositionTracker tracking: spaceships.
	sequence := TrenchRunSequence withAll: spaceships
]

{ #category : #'asserting state' }
TrenchRunGame >> isFinished [

	^ state isFinished.
]

{ #category : #'asserting state' }
TrenchRunGame >> isStarted [

	^ state isStarted
]

{ #category : #'accessing - positions' }
TrenchRunGame >> lapOf: aShip [

	^ (self positionOf: aShip) lap
]

{ #category : #'turn related' }
TrenchRunGame >> move: ship anAmountOf: squares [

	| currentLap nextLap currentSquare nextSquare |
	currentSquare := self squareOf: ship.
	currentLap := self lapOf: ship.
	nextSquare := currentSquare + squares \\ gameBoard length.
	nextLap := currentLap
	           +
	           (currentSquare + squares - nextSquare / gameBoard length).

	nextLap < 1 ifTrue: [ 
		nextLap := 1.
		nextSquare := 1 ].

	nextLap > endingLap
		ifTrue: [ 
			positionTracker move: ship at: 1 after: endingLap + 1.
			self end ]
		ifFalse: [ positionTracker move: ship at: nextSquare after: nextLap ]
]

{ #category : #'turn related' }
TrenchRunGame >> move: spaceship by: aNumberOfParsecs [

	self move: spaceship anAmountOf: (aNumberOfParsecs / gameBoard parsecsPerSquare)
]

{ #category : #'turn related' }
TrenchRunGame >> moveAllSpaceshipToSquareOne [
	(self spaceships) do: [ :aSpaceship | self move: aSpaceship anAmountOf: (1 - (self squareOf: aSpaceship)) ]
]

{ #category : #'turn related' }
TrenchRunGame >> moveAllSpaceshipsAnAmountOf: squares exceptFor: aSpaceship [
	|spaceshipsToMove|
	spaceshipsToMove := self spaceships.
	spaceshipsToMove remove: aSpaceship.
	spaceshipsToMove do: [ :spaceship | self move: spaceship anAmountOf: (0 - squares) ].
]

{ #category : #'turn related' }
TrenchRunGame >> playNextTurn [

	| diceRollResult ship |
	ship := sequence nextInSequence.
	state update: self.
	diceRollResult := dice roll.
	self move: ship anAmountOf: diceRollResult.
	self isFinished ifFalse: [ 
		gameBoard applyEffectAt: (self squareOf: ship) to: ship on: self ]
]

{ #category : #private }
TrenchRunGame >> positionOf: aShip [

	^ positionTracker positionOf: aShip ifAbsent: [  ]
]

{ #category : #'accessing - positions' }
TrenchRunGame >> positions [ 

	^positionTracker positions.
]

{ #category : #'accessing - positions' }
TrenchRunGame >> ranking [

	| rankingSize |

	rankingSize := 3 min: (self positions size).

	^ Dictionary
		  newFromKeys: (1 to: rankingSize by: 1)
		  andValues: (self positions
				   collect: [ :position | position ship name ]
				   from: 1
				   to: rankingSize)
]

{ #category : #accessing }
TrenchRunGame >> spaceships [ 

	^ positionTracker spaceships.
]

{ #category : #'accessing - positions' }
TrenchRunGame >> squareOf: aShip [

	^ (self positionOf: aShip) square
]

{ #category : #'accessing - positions' }
TrenchRunGame >> winner [

	^ state winner: self
]