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
	game := TrenchRunGameInstance withParticipating: {aShip} rolling: aDiceCup on: aBoard.
	aShip startTurn.
	
	self assert: [game isStarted not].
]

{ #category : #tests }
GameInstanceTest >> testAskingForGameStateWhenStartedReturnsStarted [
	|game aShip aDiceCup aBoard|
	aShip := Spaceship new.
	aBoard := Board sized: 10.
	aDiceCup := DiceCup with:(LoadedDie with: 7).
	game := TrenchRunGameInstance withParticipating: {aShip} rolling: aDiceCup on: aBoard.
	aShip startTurn.
	
	self assert: [game isStarted].
]

{ #category : #tests }
GameInstanceTest >> testGamePlayedAutomaticallyFinishedWithValidWinner [
	|aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame winner|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := Die with: 6.
	aBoard := Board sized: 10.

	aGame := TrenchRunGameInstance withParticipating: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} rolling: aLoadedDie on: aBoard.

	aGame startAutomatedMatch.

	winner := aGame winner.
	
	self assert: [((aGame isStarted not) and: (winner isNotNil))].
]

{ #category : #tests }
GameInstanceTest >> testMultipleShipsPositionsOnceGameIsFinished [
	|aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame winner|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 8.
	aBoard := Board sized: 10.
  
	aGame := TrenchRunGameInstance withParticipating: {aSpaceshipNamedJorge. aSpaceshipNamedJulian. aSpaceshipNamedHernan} rolling: aLoadedDie on: aBoard.
  
	aSpaceshipNamedJorge startTurn.
	aSpaceshipNamedJulian startTurn.
	aSpaceshipNamedHernan startTurn.
  aSpaceshipNamedJorge startTurn.
  
	winner := aGame winner.
	
	self assert: [((aGame isStarted not) and: (winner name match: 'Jorge'))].
]

{ #category : #tests }
GameInstanceTest >> testOneShippedGameCanOnlyKnowWinnerOnceGameIsFinished [
	|aShip aBoard aGame aLoadedDie winner|

	aShip := Spaceship named: 'Enterprise'.
	aLoadedDie := LoadedDie with: 11.
	aBoard := Board sized: 10.
	aGame  := TrenchRunGameInstance withParticipating: {aShip} rolling: aLoadedDie on: aBoard.
	
	aShip startTurn.
    
	winner := aGame winner.
	
	self assert: [(aGame isStarted not) and: (winner name match: 'Enterprise')].
]

{ #category : #tests }
GameInstanceTest >> testShipCannotStartAnotherTurnOnceGameHasFinished [

	|aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 15.
	aBoard := Board sized: 10.
	aGame := TrenchRunGameInstance withParticipating: {aSpaceshipNamedJorge. aSpaceshipNamedJulian. aSpaceshipNamedHernan} rolling: aLoadedDie on: aBoard.

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

	aGame := TrenchRunGameInstance withParticipating: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} rolling: aLoadedDie on: aBoard.
	
	[aGame winner] whileNil: [ 
		self assert: [aGame isStarted not].
		aSpaceshipNamedJorge startTurn.
		aGame winner ifNil: [ 
			aSpaceshipNamedJulian startTurn.
		].
	].
	self assert: [aGame isStarted not].
	
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithNoBoardOrDiceIsInvalid [
	|aBarebonesGame aRandomShip|
	aBarebonesGame := TrenchRunGameInstance new.
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
	game := TrenchRunGameInstance withParticipating: {aShip} rolling: aDiceCup on: aBoard.
	aShip startTurn.
	
	self assert: [game isStarted].
]

{ #category : #tests }
GameInstanceTest >> testStartingGameWithTwoOrMoreSpaceshipsIsValid [
	|game aFirstShip aSecondShip aDiceCup aBoard|
	aFirstShip := Spaceship named: 'Planet Express'.
	aSecondShip := Spaceship named: 'Enterprise'.
	
	aBoard := Board sized: 10.
	aDiceCup := DiceCup with:(LoadedDie with: 5).
	
	"When two or more spaceships want to be added to a game, message withSpaceships:diceCup:board: must be used"
	game := TrenchRunGameInstance withParticipating: {aFirstShip . aSecondShip } rolling: aDiceCup on: aBoard.
	aFirstShip startTurn.
	aSecondShip startTurn.
	
	self assert: [game isStarted].
]

{ #category : #tests }
GameInstanceTest >> testTwoShippedGameCanOnlyKnowWinnerOnceGameIsFinished [
	|aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame winner|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board sized: 10.

	aGame := TrenchRunGameInstance withParticipating: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} rolling: aLoadedDie on: aBoard.

	aSpaceshipNamedJulian startTurn.
  aSpaceshipNamedJorge startTurn.
  aSpaceshipNamedJulian startTurn.

	winner := aGame winner.
	
	self assert: [((aGame isStarted not) and: (winner name match: 'Julian'))].
]

{ #category : #tests }
GameInstanceTest >> testWinnerOfFixedMatchMatchesRanking [
	|aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame ranking|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board sized: 10.

	aGame := TrenchRunGameInstance withParticipating: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} rolling: aLoadedDie on: aBoard.

	aSpaceshipNamedJorge startTurn.
	aSpaceshipNamedJulian startTurn.
	aSpaceshipNamedJorge startTurn.

	ranking := aGame positions.
	
	
	self assert: (ranking at: aSpaceshipNamedJorge ) > (ranking at: aSpaceshipNamedJulian ).
]

{ #category : #tests }
GameInstanceTest >> testWinnerOfFixedMatchMatchesReadableRanking [
	|aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame ranking winner |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board sized: 10.

	aGame := TrenchRunGameInstance withParticipating: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} rolling: aLoadedDie on: aBoard.

	aSpaceshipNamedJorge startTurn.
	aSpaceshipNamedJulian startTurn.
	aSpaceshipNamedJorge startTurn.
	
	winner := aGame winner.
	ranking := aGame positions.
	
	self assert: [ (ranking at: 1) equals: winner ].
]
