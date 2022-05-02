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

	| game aShip aDiceCup aBoard |
	aShip := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 5.
	aDiceCup := DiceCup with: (LoadedDie with: 10).
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard.
	game startTurn: aShip.

	self assert: [ game isFinished ]
]

{ #category : #tests }
GameInstanceTest >> testAskingForGameStateWhenStartedReturnsStarted [
	|game aShip aDiceCup aBoard|
	aShip := Spaceship new.
	aBoard := Board sized: 10.
	aDiceCup := DiceCup with:(LoadedDie with: 7).
	game := TrenchRunGameInstance withParticipating: {aShip} rolling: aDiceCup on: aBoard.
	game startTurn: aShip.
	
	self assert: [game isStarted].
]

{ #category : #tests }
GameInstanceTest >> testAskingForWinnerWhenGameStillHasNotFinishedIsInvalid [

	|game board aSpaceship die |
	board := Board sized: 10.
	aSpaceship := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 7.
	game := TrenchRunGameInstance withParticipating: {aSpaceship} rolling: die on: board.
	
	
	self 
		should: [ game winner ]
		raise: Error 
		withMessage: 'There cannot be a winner if the game has not finished'.
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
  
	aGame startTurn: aSpaceshipNamedJorge.
	aGame startTurn: aSpaceshipNamedJulian.
	aGame startTurn: aSpaceshipNamedHernan.
  aGame startTurn: aSpaceshipNamedJorge.
  
	winner := aGame winner.
	
	self assert: [((aGame isFinished ) and: (winner name match: 'Jorge'))].
]

{ #category : #tests }
GameInstanceTest >> testOneShippedGameCanOnlyKnowWinnerOnceGameIsFinished [
	|aShip aBoard aGame aLoadedDie winner|

	aShip := Spaceship named: 'Enterprise'.
	aLoadedDie := LoadedDie with: 11.
	aBoard := Board sized: 10.
	aGame  := TrenchRunGameInstance withParticipating: {aShip} rolling: aLoadedDie on: aBoard.
	
	aGame startTurn: aShip.
    
	winner := aGame winner.
	
	self assert: ((aGame isFinished) and: (winner name match: 'Enterprise')).
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

	aGame startTurn: aSpaceshipNamedJorge.

	self 
		should: [ aGame startTurn: aSpaceshipNamedHernan. ]
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
	
	[aGame isFinished] whileFalse: [
		aGame startTurn: aSpaceshipNamedJorge.
		aGame isFinished ifFalse: [ 
			aGame startTurn: aSpaceshipNamedJulian.
		].
	].
	self assert: (aGame isFinished and: [aGame winner name match: 'Jorge']).
	
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithOneSpaceshipIsValid [
	|game aShip aDiceCup aBoard|
	aShip := Spaceship new.
	aBoard := Board sized: 10.
	aDiceCup := DiceCup with:(LoadedDie with: 7).
	
	"When only one spaceship is being added to game, message withShip:diceCup:board: can be used"
	game := TrenchRunGameInstance withParticipating: {aShip} rolling: aDiceCup on: aBoard.
	game startTurn: aShip.
	
	self assert: (game isStarted).
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
	game startTurn: aFirstShip.
	game startTurn: aSecondShip.
	
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

	aGame startTurn: aSpaceshipNamedJulian.
	aGame startTurn: aSpaceshipNamedJorge.
	aGame startTurn: aSpaceshipNamedJulian.

	winner := aGame winner.
	
	self assert: ((aGame isFinished and: (winner name match: 'Julian'))).
]

{ #category : #tests }
GameInstanceTest >> testWinnerOfFixedMatchMatchesPositionsTable [
	|aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame positions|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board sized: 10.

	aGame := TrenchRunGameInstance withParticipating: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} rolling: aLoadedDie on: aBoard.

	aGame startTurn: aSpaceshipNamedJorge.
	aGame startTurn: aSpaceshipNamedJulian.
	aGame startTurn: aSpaceshipNamedJorge.

	positions := aGame positions.
	
	self assert: (aGame isFinished and: 
							[(aGame winner name match: 'Jorge') and: 
								[(positions at: aSpaceshipNamedJorge) = 10]
							]
					 ).
]
