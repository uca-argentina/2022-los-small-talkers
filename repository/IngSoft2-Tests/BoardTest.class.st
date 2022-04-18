Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^self 
		should: aBlock 
		raise: anErrorType  
		whoseDescriptionIncludes: anErrorMessage  
		description: 'Test did not fail for expected reason'
]

{ #category : #tests }
BoardTest >> testAssociatingABoardWithAGame [
	|aRegisteredSpaceship aBoard aGame aLoadedDie|

	aRegisteredSpaceship := Spaceship new.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 withSpaceships: {aRegisteredSpaceship}.
	
	aGame := GameInstance withShip: {aRegisteredSpaceship} diceCup: aLoadedDie board: aBoard.
	aBoard associateGame: aGame.
	
	self assert: [ aBoard game == aGame ].
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereLengthIsValid [
	
	| aRegisteredSpaceship aBoard |
	aRegisteredSpaceship := Spaceship new.
	
	self 
		should: [  aBoard := Board sized: -10 withSpaceships: {aRegisteredSpaceship}]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'.


	
]

{ #category : #tests }
BoardTest >> testMovingAShipCannotBeDoneWithoutAStartedGame [
	
	|aRegisteredSpaceship  aBoard aGame aLoadedDie|

	aRegisteredSpaceship := Spaceship new.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 withSpaceships: {aRegisteredSpaceship}.
	
	aGame := GameInstance withShip: {aRegisteredSpaceship} diceCup: aLoadedDie board: aBoard.
	aBoard associateGame: aGame.
	
	self 
		should: [ aBoard move: aRegisteredSpaceship forwardSquares: 2 ] 
		raise: Error
		withMessage: 'Cannot move forward if game is not started'.
]

{ #category : #tests }
BoardTest >> testMovingNotRegisteredSpaceshipIsInvalid [
	
	|aRegisteredSpaceship anUnregisteredSpaceship aBoard aGame aLoadedDie|

	aRegisteredSpaceship := Spaceship new.
	anUnregisteredSpaceship := Spaceship new.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 withSpaceships: {aRegisteredSpaceship}.
	
	aGame := GameInstance withShip: {aRegisteredSpaceship} diceCup: aLoadedDie board: aBoard.
	aBoard associateGame: aGame.
	
	aGame start.
	
	self
		should: [ aBoard move: anUnregisteredSpaceship forwardSquares: 6. ]
		raise: Error 
		withMessage: 'Cannot get position of unregistered spaceship'.
]

{ #category : #tests }
BoardTest >> testMovingRegisteredSpaceshipToGreaterOrEqualThanLastSquareChangesGameStateToFinished [
	
	|aGame aLoadedDie aBoard aSpaceship1 aCollectionOfSpaceships|

	aLoadedDie := LoadedDie with: 4.
	aSpaceship1 := Spaceship named: 'Enterprise'.
	aCollectionOfSpaceships := Bag new.
	aCollectionOfSpaceships add: aSpaceship1.
	aBoard := Board sized: 3 withSpaceships: aCollectionOfSpaceships.
	
	aGame := GameInstance withShip: aCollectionOfSpaceships diceCup: aLoadedDie board: aBoard.
	aBoard associateGame: aGame.
	
	aGame start.
	
	aBoard move: aSpaceship1 forwardSquares: aLoadedDie roll.
	
	self assert: [ aGame state printState match: 'finished' ].
	

]

{ #category : #tests }
BoardTest >> testMovingRegisteredSpaceshipToNegativeSquarePlacesItAtStartingSquare [
	|aRegisteredSpaceship aBoard aGame aLoadedDie|

	aRegisteredSpaceship := Spaceship new.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 withSpaceships: {aRegisteredSpaceship}.
	
	aGame := GameInstance withShip: {aRegisteredSpaceship} diceCup: aLoadedDie board: aBoard.
	aBoard associateGame: aGame.
	
	aGame start.
	
	self 
		should: [ aBoard move: aRegisteredSpaceship forwardSquares: -6 ] 
		raise: Error
		withMessage: 'Cannot move forward negative squares'.
]

{ #category : #tests }
BoardTest >> testObtainingPositionOfUnregisteredShipIsInvalid [

	|aRegisteredSpaceship anUnregisteredSpaceship aBoard|

	aRegisteredSpaceship := Spaceship new.
	anUnregisteredSpaceship := Spaceship new.
	
	aBoard := Board sized: 10 withSpaceships: {aRegisteredSpaceship}.
	
	self 
		should: [ aBoard positionOf: anUnregisteredSpaceship ]
		raise: Error 
		withMessage: 'Cannot get position of unregistered spaceship'.
]
