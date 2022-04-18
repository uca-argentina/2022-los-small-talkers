Class {
	#name : #GameInstanceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameInstanceTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^self 
		should: aBlock 
		raise: anErrorType  
		whoseDescriptionIncludes: anErrorMessage  
		description: 'Test did not fail for expected reason'
]

{ #category : #tests }
GameInstanceTest >> testAskingForGameStateWhenFinishedReturnsFinished [
	|game aShip aDiceCup aBoard|
	aShip := Spaceship new.
	aBoard := Board sized: 5.
	aDiceCup := DiceCup with:(LoadedDie with: 10).
	game := GameInstance withShip: aShip diceCup: aDiceCup board: aBoard.
	aShip startTurn.
	
	self assert: (game printState) equals: 'finished'.
]

{ #category : #tests }
GameInstanceTest >> testAskingForGameStateWhenNotStartedReturnsNotStarted [
	|game aShip aDiceCup aBoard|
	aShip := Spaceship new.
	aBoard := Board sized: 5.
	aDiceCup := DiceCup with:(LoadedDie with: 10).
	game := GameInstance withShip: aShip diceCup: aDiceCup board: aBoard.
	
	self assert: (game printState) equals: 'not started'.
]

{ #category : #tests }
GameInstanceTest >> testAskingForGameStateWhenStartedReturnsStarted [
	|game aShip aDiceCup aBoard|
	aShip := Spaceship new.
	aBoard := Board sized: 10.
	aDiceCup := DiceCup with:(LoadedDie with: 7).
	game := GameInstance withShip: aShip diceCup: aDiceCup board: aBoard.
	aShip startTurn.
	
	self assert: (game printState) equals: 'started'.
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithNoBoardOrDiceIsInvalid [
	|aBarebonesGame aRandomShip|
	aBarebonesGame := GameInstance new.
	aRandomShip := Spaceship new.
	
	self 
		should: [ aBarebonesGame startTurn: aRandomShip. ]
		raise: Error 
		withMessage: 'Cannot start a game without board or dice'.
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithOneSpaceshipIsValid [
	|game aShip aDiceCup aBoard|
	aShip := Spaceship new.
	aBoard := Board sized: 10.
	aDiceCup := DiceCup with:(LoadedDie with: 7).
	
	"When only one spaceship is being added to game, message withShip:diceCup:board: can be used"
	game := GameInstance withSpaceships: {aShip} diceCup: aDiceCup board: aBoard.
	aShip startTurn.
	
	self assert: (game printState) equals: 'started'.
]

{ #category : #tests }
GameInstanceTest >> testStartingGameWithTwoOrMoreSpaceshipsIsValid [

	|game aFirstShip aSecondShip aDiceCup aBoard|
	aFirstShip := Spaceship named: 'Planet Express'.
	aSecondShip := Spaceship named: 'Enterprise'.
	
	aBoard := Board sized: 10.
	aDiceCup := DiceCup with:(LoadedDie with: 5).
	
	"When only one spaceship is being added to game, message withShip:diceCup:board: can be used"
	game := GameInstance withSpaceships: {aFirstShip . aSecondShip } diceCup: aDiceCup board: aBoard.
	aFirstShip startTurn.
	aSecondShip startTurn.
	
	self assert: (game printState) equals: 'started'.
]
