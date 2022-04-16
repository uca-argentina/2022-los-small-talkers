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
BoardTest >> testAddingOneSpaceshipToBoard [

	| aSpaceship aBoard |
	aSpaceship := Spaceship new.
	aBoard := Board sized: 5.
	
	aBoard registerSingleSpaceship: aSpaceship.

]

{ #category : #tests }
BoardTest >> testAddingTwoSpaceshipsToBoard [

	| aFirstSpaceship aBoard aSecondSpaceship |
	aFirstSpaceship := Spaceship new.
	aSecondSpaceship := Spaceship new.
	aBoard := Board sized: 5.
	
	aBoard registerMultipleSpaceships: {aFirstSpaceship. aSecondSpaceship }.

]

{ #category : #tests }
BoardTest >> testAssociatingABoardWithAGame [

	|aGameInstance aBoard|
	
	aBoard := Board sized: 10.
	aGameInstance := GameInstance new.
	
	self shouldBeImplemented.
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
		should: [ aBoard move: anUnregisteredSpaceship toSquare: 6. ]
		raise: Error 
		withMessage: 'Cannot move unregistered Spaceship'.
]

{ #category : #tests }
BoardTest >> testMovingRegisteredSpaceshipToGreaterOrEqualThanLastSquareChangesGameStateToFinished [

	|aSpaceship aBoard|
	
	self shouldBeImplemented.
]

{ #category : #tests }
BoardTest >> testMovingRegisteredSpaceshipToNegativeSquarePlacesItAtStartingSquare [
	
	self shouldBeImplemented.
]
