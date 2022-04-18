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
	|aGameInstance aBoard|
	
	aBoard := Board sized: 10.
	aGameInstance := GameInstance board: aBoard.
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereLengthEqualsZero [
	self 
		should: [Board sized: 0]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'.
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereLengthIsValid [
	| aBoard |
	aBoard := Board sized: 10.
]

{ #category : #tests }
BoardTest >> testMovingNotRegisteredSpaceshipIsInvalid [
	|anUnregisteredSpaceship aBoard|
	anUnregisteredSpaceship := Spaceship new.
	aBoard := Board sized: 10.
	
	self
		should: [ aBoard move: anUnregisteredSpaceship forwardSquares: 6. ]
		raise: Error 
		withMessage: 'Cannot get position of unregistered spaceship'.
]

{ #category : #tests }
BoardTest >> testMovingRegisteredSpaceshipToGreaterOrEqualThanLastSquareChangesGameStateToFinished [
	|aSpaceship aBoard aGame aDiceCup|
	aSpaceship := Spaceship new.
	aBoard := Board sized: 10.
	aDiceCup := DiceCup with: (LoadedDie with: 14).
	aGame := GameInstance withShip: aSpaceship diceCup: aDiceCup board: aBoard.
	
	aSpaceship startTurn.
	
	self assert: (aGame printState) equals: 'finished'.
]

{ #category : #tests }
BoardTest >> testMovingRegisteredSpaceshipToNegativeSquarePlacesItAtStartingSquare [
	|aBoard aSpaceship|
	aSpaceship := Spaceship named: 'Lebron James'.
	aBoard := Board sized: 10 withSpaceships: { aSpaceship }.
	
	self 
		should: [ aBoard move: aSpaceship forwardSquares: -6 ] 
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
		should: [ aBoard positionOfShip: anUnregisteredSpaceship ]
		raise: Error 
		withMessage: 'Cannot get position of unregistered spaceship'.
]
