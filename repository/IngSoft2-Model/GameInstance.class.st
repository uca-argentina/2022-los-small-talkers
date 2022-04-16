Class {
	#name : #GameInstance,
	#superclass : #Object,
	#instVars : [
		'dice',
		'spaceships',
		'board',
		'diceCup',
		'gameBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameInstance class >> withShip: aSpaceship diceCup: aDiceCup board: aBoard [ 
	^ self new initilializeWithShips: { aSpaceship } diceCup: aDiceCup board: aBoard. 
]

{ #category : #initialization }
GameInstance >> initilializeWithShips: aCollectionOfShips diceCup: aDiceCup board: aBoard [ 
	gameBoard := aBoard.
	diceCup := aDiceCup.
	gameBoard addPlayer: aCollectionOfShips.
	
]
