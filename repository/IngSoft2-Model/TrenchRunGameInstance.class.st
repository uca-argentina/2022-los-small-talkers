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

{ #category : #accessing }
TrenchRunGameInstance >> currentLeader [

	^ (self positions keyAtValue: (self positions values detectMax: [ :square | square ] )) 
]

{ #category : #private }
TrenchRunGameInstance >> end [
	state := Finished new.
]

{ #category : #initialization }
TrenchRunGameInstance >> initializeWithParticipating: aCollectionOfSpaceships rolling: aDiceCup on: aBoard [

	gameBoard := aBoard.
	dice := aDiceCup.
	state := Started new.
	positionTracker := PositionTracker withSpaceships: aCollectionOfSpaceships.
]

{ #category : #'asserting state' }
TrenchRunGameInstance >> isFinished [

	^ state isFinished.
]

{ #category : #'asserting state' }
TrenchRunGameInstance >> isStarted [
	^ state isStarted.
]

{ #category : #accessing }
TrenchRunGameInstance >> positions [ 

	^positionTracker positions.
]

{ #category : #'turn related' }
TrenchRunGameInstance >> startTurn: ship [

	| diceRollResult currentPosition nextPosition |
	currentPosition := (positionTracker
		                   positionOf: ship
		                   ifAbsent: [ 
		                   Error signal:
			                   'Cannot start turn of an unknown ship' ]) square.

	state update: self.

	diceRollResult := dice roll.

	(diceRollResult + currentPosition > gameBoard length) ifTrue: [ 
			nextPosition := gameBoard length.
			positionTracker move: ship to: nextPosition.
			self end 
		] ifFalse: [ 
			nextPosition := diceRollResult + currentPosition.
			positionTracker move: ship to: nextPosition 
		]
]

{ #category : #accessing }
TrenchRunGameInstance >> winner [
  ^state winner: self.
]
