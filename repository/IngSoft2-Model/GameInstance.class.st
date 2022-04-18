Class {
	#name : #GameInstance,
	#superclass : #Object,
	#instVars : [
		'dice',
		'spaceships',
		'board',
		'diceCup',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameInstance class >> board: aBoard [ 
	^self new initializeWithBoard: aBoard. 
]

{ #category : #'instance creation' }
GameInstance class >> withShip: aCollectionOfSpaceships diceCup: aDiceCup board: aBoard [ 
	^ self new initializeWithShips: aCollectionOfSpaceships diceCup: aDiceCup board: aBoard. 
]

{ #category : #'accessing - arguments' }
GameInstance >> end [

	state := GameStateFinished new.
]

{ #category : #initialization }
GameInstance >> initializeWithBoard: aBoard [
	board := aBoard.
	aBoard associateGame: self.
]

{ #category : #initialization }
GameInstance >> initializeWithShips: aCollectionOfSpaceships diceCup: aDiceCup board: aBoard [ 
	board  := aBoard.
	diceCup := aDiceCup.
	spaceships := aCollectionOfSpaceships.
	state := GameStateNotStarted new.
]

{ #category : #actions }
GameInstance >> plays: aSpaceship [ 
		"
	[ state printState match: 'started' ] whileTrue: [ 
		spaceships do: [ :ship | [ state printState match: 'started' ] ifTrue: (self plays: ship)]
	 ]"
	
	
	board move: aSpaceship forwardSquares: (diceCup roll). 
]

{ #category : #'accessing - arguments' }
GameInstance >> start [

	state := GameStateStarted new.
	
	
]

{ #category : #'accessing - arguments' }
GameInstance >> state [
	^ state
]
