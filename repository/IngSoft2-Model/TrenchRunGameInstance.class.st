Class {
	#name : #TrenchRunGameInstance,
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
TrenchRunGameInstance class >> withParticipating: spaceships rolling: aDiceCup on: aBoard endLap: lapNumber [

	^ self new
		  initializeWithParticipating: spaceships
		  rolling: aDiceCup
		  on: aBoard
		  endLap: lapNumber.
]

{ #category : #accessing }
TrenchRunGameInstance >> board [
	^gameBoard.
]

{ #category : #'accessing - positions' }
TrenchRunGameInstance >> currentLeader [

	^ (self positions detectMax:
		  [ :position | position lap * gameBoard length + position square ])
			  ship
]

{ #category : #private }
TrenchRunGameInstance >> end [
	state := Finished new.
]

{ #category : #initialization }
TrenchRunGameInstance >> initializeWithParticipating: spaceships rolling: aDiceCup on: aBoard endLap: lapNumber [

	gameBoard := aBoard.
	dice := aDiceCup.
	state := Started new.
	endingLap := lapNumber.
	positionTracker := PositionTracker withAll: spaceships.
	sequence := TrenchRunSequence withAll: spaceships
]

{ #category : #'asserting state' }
TrenchRunGameInstance >> isFinished [

	^ state isFinished.
]

{ #category : #'asserting state' }
TrenchRunGameInstance >> isStarted [
	^ state isStarted.
]

{ #category : #'accessing - positions' }
TrenchRunGameInstance >> lapOf: aShip [

	^ (self positionOf: aShip) lap
]

{ #category : #'turn related' }
TrenchRunGameInstance >> move: ship anAmountOf: squares [

	| currentLap nextLap currentSquare nextSquare |
	currentSquare := self squareOf: ship.
	currentLap := self lapOf: ship.
	nextSquare := currentSquare + squares \\ gameBoard length.
	nextLap := currentLap
	           +
	           (currentSquare + squares - nextSquare / gameBoard length).

	nextLap < 1 ifTrue: [ 
		nextLap := 1.
		nextSquare := 1
	].

	nextLap > endingLap
		ifTrue: [ 
			positionTracker move: ship to: 1 lap: endingLap + 1.
			self end ]
		ifFalse: [ positionTracker move: ship to: nextSquare lap: nextLap ]
]

{ #category : #'turn related' }
TrenchRunGameInstance >> playNextTurn [

	| diceRollResult ship |
	ship := sequence nextInSequence.
	state update: self.
	diceRollResult := dice roll.
	self move: ship anAmountOf: diceRollResult.
	gameBoard applyEffectTo: ship at:(self squareOf: ship) from: self.
]

{ #category : #private }
TrenchRunGameInstance >> positionOf: aShip [

	^ positionTracker positionOf: aShip ifAbsent: [  ]
]

{ #category : #'accessing - positions' }
TrenchRunGameInstance >> positions [ 

	^positionTracker positions.
]

{ #category : #'accessing - positions' }
TrenchRunGameInstance >> ranking [

	| sortedPositions rankingSize |
	sortedPositions := SortedCollection sortUsing: [ :firstPosition :secondPosition | 
		                   firstPosition lap * gameBoard length + firstPosition square >
		                   (secondPosition lap * gameBoard length + secondPosition square) ].
	sortedPositions addAll: self positions.
	rankingSize := 3 min: sortedPositions size.
	
	^ Dictionary newFromKeys: (1 to: rankingSize by: 1) andValues: (sortedPositions
			collect: [ :position | position ship name ]
			from: 1
			to: rankingSize ).
]

{ #category : #accessing }
TrenchRunGameInstance >> spaceships [ 

	^ positionTracker spaceships.
]

{ #category : #'accessing - positions' }
TrenchRunGameInstance >> squareOf: aShip [

	^ (self positionOf: aShip) square
]

{ #category : #'accessing - positions' }
TrenchRunGameInstance >> winner [
  ^state winner: self.
]
