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
GameInstanceTest >> testMultipleShipsPositionsOnceGameIsFinished [

	|aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame winner|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 withSpaceships: {aSpaceshipNamedJorge. aSpaceshipNamedJulian. aSpaceshipNamedHernan}.

	aGame := GameInstance withShip: {aSpaceshipNamedJorge. aSpaceshipNamedJulian. aSpaceshipNamedHernan} diceCup: aLoadedDie board: aBoard.
	aBoard associateGame: aGame.
	
	aGame start.

	aBoard move: aSpaceshipNamedJorge forwardSquares: 2.
	aBoard move: aSpaceshipNamedJulian forwardSquares: 6.
	aBoard move: aSpaceshipNamedHernan forwardSquares: 15.

	winner := aBoard getWinner: {aSpaceshipNamedJorge. aSpaceshipNamedJulian. aSpaceshipNamedHernan}.
	
	self assert: [((aBoard positionOf: winner) == aBoard length) and: [((aGame state printState) match: 'finished') and: ((winner name) match: 'Hernan')]]
	
	
]

{ #category : #tests }
GameInstanceTest >> testOneShippedGameWinnerCanBeKnownOnceGameIsFinished [

	|aRegisteredSpaceship aBoard aGame aLoadedDie winner|

	aRegisteredSpaceship := Spaceship new.
	aLoadedDie := LoadedDie with: 11.
	aBoard := Board sized: 10 withSpaceships: {aRegisteredSpaceship}.
	
	aGame := GameInstance withShip: {aRegisteredSpaceship} diceCup: aLoadedDie board: aBoard.
	aBoard associateGame: aGame.
	
	aGame start.
	aBoard move: aRegisteredSpaceship forwardSquares: aLoadedDie roll.

	winner := aBoard getWinner: {aRegisteredSpaceship}.
	
	self assert: [((aBoard positionOf: winner) == aBoard length) and: ((aGame state printState) match: 'finished')]
	
	
]

{ #category : #tests }
GameInstanceTest >> testShipCannotMoveOnceGameHasFinished [

	|aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 withSpaceships: {aSpaceshipNamedJorge. aSpaceshipNamedJulian. aSpaceshipNamedHernan}.

	aGame := GameInstance withShip: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} diceCup: aLoadedDie board: aBoard.
	aBoard associateGame: aGame.
	
	aGame start.

	aBoard move: aSpaceshipNamedJorge forwardSquares: 2.
	aBoard move: aSpaceshipNamedJulian forwardSquares: 11.

	self 
		should: [ aBoard move: aSpaceshipNamedHernan forwardSquares: 6. ]
		raise: Error 
		withMessage: 'Cannot move forward if game is not started'.
	
	
]

{ #category : #tests }
GameInstanceTest >> testStartedGamePlaysUntilOneSpaceshipWins [
	|aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 withSpaceships: {aSpaceshipNamedJorge. aSpaceshipNamedJulian. aSpaceshipNamedHernan}.

	aGame := GameInstance withShip: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} diceCup: aLoadedDie board: aBoard.
	aBoard associateGame: aGame.
	
	aGame start.

]

{ #category : #tests }
GameInstanceTest >> testTwoShippedGameWinnerCanBeKnownOnceGameIsFinished [

	|aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame winner|
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 withSpaceships: {aSpaceshipNamedJorge. aSpaceshipNamedJulian}.

	aGame := GameInstance withShip: {aSpaceshipNamedJorge. aSpaceshipNamedJulian} diceCup: aLoadedDie board: aBoard.
	aBoard associateGame: aGame.
	
	aGame start.

	aBoard move: aSpaceshipNamedJorge forwardSquares: 2.
	aBoard move: aSpaceshipNamedJulian forwardSquares: 11.

	winner := aBoard getWinner: {aSpaceshipNamedJorge. aSpaceshipNamedJulian}.
	
	self assert: [((aBoard positionOf: winner) == aBoard length) and: [((aGame state printState) match: 'finished') and: ((winner name) match: 'Julian')]]
	
	
]
