Class {
	#name : #TrenchRunGameInstance,
	#superclass : #Object,
	#instVars : [
		'dice',
		'gameBoard',
		'state',
		'positionTracker',
		'sequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrenchRunGameInstance class >> withParticipating: spaceships rolling: aDiceCup on: aBoard [ 
	^ self new initializeWithParticipating: spaceships rolling: aDiceCup on: aBoard. 
]

{ #category : #accessing }
TrenchRunGameInstance >> currentLeader [

	^ (self positions keyAtValue: (self positions values detectMax: [ :square | square ] )) 
]

{ #category : #private }
TrenchRunGameInstance >> end [
	state := Finished new.
]

{ #category : #initialization }
TrenchRunGameInstance >> initializeWithParticipating: spaceships rolling: aDiceCup on: aBoard [

	gameBoard := aBoard.
	dice := aDiceCup.
	state := Started new.
	positionTracker := PositionTracker withAll: spaceships.
	sequence := TrenchRunSpaceshipSequence withAll: spaceships.
]

{ #category : #'asserting state' }
TrenchRunGameInstance >> isFinished [

	^ state isFinished.
]

{ #category : #'asserting state' }
TrenchRunGameInstance >> isStarted [
	^ state isStarted.
]

{ #category : #'turn related' }
TrenchRunGameInstance >> playNextTurn [

	| diceRollResult currentPosition nextPosition ship |
	ship := sequence nextInSequence.

	currentPosition := (positionTracker positionOf: ship ifAbsent: [  ])
		                   square.


	state update: self.

	diceRollResult := dice roll.

	diceRollResult + currentPosition > gameBoard length
		ifTrue: [ 
			nextPosition := gameBoard length.
			positionTracker move: ship to: nextPosition.
			self end ]
		ifFalse: [ 
			nextPosition := diceRollResult + currentPosition.
			positionTracker move: ship to: nextPosition ]
]

{ #category : #accessing }
TrenchRunGameInstance >> positions [ 

	^positionTracker positions.
]

{ #category : #accessing }
TrenchRunGameInstance >> winner [
  ^state winner: self.
]
