Class {
	#name : #GameInstance,
	#superclass : #Object,
	#instVars : [
		'dice',
		'spaceships',
		'board',
		'diceCup',
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

{ #category : #accessing }
GameInstance >> end [

	state := GameStateFinished new.
]

{ #category : #initialization }
GameInstance >> initializeWithBoard: aBoard [
	board := aBoard.
	aBoard associateGame: self.
]

{ #category : #initialization }
GameInstance >> initilializeWithShips: aCollectionOfShips diceCup: aDiceCup board: aBoard [ 
	gameBoard := aBoard.
	diceCup := aDiceCup.
	gameBoard addPlayer: aCollectionOfShips.
	
]
