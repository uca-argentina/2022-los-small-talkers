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

{ #category : #tests }
GameInstanceTest >> testMultipleShipsPositionsOnceGameIsFinished [
	|aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame winner|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 8.
	aBoard := Board sized: 10.
  
	aGame := GameInstance withSpaceships: {aSpaceshipNamedJorge. aSpaceshipNamedJulian. aSpaceshipNamedHernan} diceCup: aLoadedDie board: aBoard.
  
	aSpaceshipNamedJorge startTurn.
	aSpaceshipNamedJulian startTurn.
	aSpaceshipNamedHernan startTurn.
  aSpaceshipNamedJorge startTurn.
  
	winner := aGame winner.
	
	self assert: [((aBoard positionOfShipNamed: winner) == aBoard length) and: (((aGame printState) match: 'finished') and: (winner match: 'Jorge'))].
]

{ #category : #tests }
GameInstanceTest >> testOneShippedGameCanOnlyKnowWinnerOnceGameIsFinished [
	|aRegisteredSpaceship aBoard aGame aLoadedDie winner|

	aRegisteredSpaceship := Spaceship new.
	aLoadedDie := LoadedDie with: 11.
	aBoard := Board sized: 10.
	aGame := GameInstance withShip: aRegisteredSpaceship diceCup: aLoadedDie board: aBoard.
	
	aRegisteredSpaceship startTurn.
    
	winner := aGame winner.
	
	self assert: [((aBoard positionOfShipNamed: winner) == aBoard length) and: ((aGame printState) match: 'finished')].
]

{ #category : #tests }
GameInstanceTest >> testShipCannotStartAnotherTurnOnceGameHasFinished [

	|aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 15.
	aBoard := Board sized: 10.
	aGame := GameInstance withSpaceships: {aSpaceshipNamedJorge. aSpaceshipNamedJulian. aSpaceshipNamedHernan} diceCup: aLoadedDie board: aBoard.

	aSpaceshipNamedJorge startTurn.

	self 
		should: [ aSpaceshipNamedHernan startTurn. ]
		raise: Error 
		withMessage: 'Cannot start another turn in a finished game'.
]

{ #category : #tests }
GameInstanceTest >> testStartedGamePlaysUntilOneSpaceshipWins [
	|aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10.

	aGame := GameInstance withSpaceships: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} diceCup: aLoadedDie board: aBoard.
	
	[aGame winner] whileNil: [ 
		self assert: ((aGame printState match: 'started') or: (aGame printState match: 'not started')).
		aSpaceshipNamedJorge startTurn.
		aGame winner ifNil: [ 
			aSpaceshipNamedJulian startTurn.
		].
	].
	self assert: (aGame printState match: 'finished').
	
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
	
	"When two or more spaceships want to be added to a game, message withSpaceships:diceCup:board: must be used"
	game := GameInstance withSpaceships: {aFirstShip . aSecondShip } diceCup: aDiceCup board: aBoard.
	aFirstShip startTurn.
	aSecondShip startTurn.
	
	self assert: (game printState) equals: 'started'.
]

{ #category : #tests }
GameInstanceTest >> testTwoShippedGameCanOnlyKnowWinnerOnceGameIsFinished [
	|aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame winner|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board sized: 10.

	aGame := GameInstance withSpaceships: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} diceCup: aLoadedDie board: aBoard.

	aSpaceshipNamedJulian startTurn.
  aSpaceshipNamedJorge startTurn.
  aSpaceshipNamedJulian startTurn.

	winner := aGame winner.
	
	self assert: [((aBoard positionOfShipNamed: winner) == aBoard length) and: (((aGame printState) match: 'finished') and: (winner match: 'Julian'))].
]
