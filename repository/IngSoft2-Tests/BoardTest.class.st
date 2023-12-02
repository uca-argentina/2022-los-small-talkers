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
BoardTest >> testBoardCreationWhereLengthLowerOrEqualThanZeroIsInvalid [

	self
		should: [ Board madeUpBy: {  } stretchedIntoParsecs: 10 ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'.
		
	self
		should: [ Board madeUpBy: {  } stretchedIntoParsecs: -10 ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereLightYearsLowerOrEqualToZeroIsInvalid [

	self
		should: [ Board madeUpBy: { BlankSquare } stretchedIntoLightYears: 0 ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'.

	self
		should: [ Board madeUpBy: { BlankSquare } stretchedIntoLightYears: -10 ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereParsecsLowerOrEqualToZeroIsInvalid [

	self
		should: [ Board madeUpBy: { BlankSquare } stretchedIntoParsecs: 0 ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'.

	self
		should: [ Board madeUpBy: { BlankSquare } stretchedIntoParsecs: -10 ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'
]

{ #category : #tests }
BoardTest >> testBoardDistanceInLightYearsIsThreeTimesAsMuchAsInParsecs [

	| board |
	board := Board madeUpBy: { BlankSquare } stretchedIntoLightYears: 10.
	self
		assert: board lightYearsPerSquare
		equals: board parsecsPerSquare * 3
]

{ #category : #tests }
BoardTest >> testCreatingABoardFromSomeRandomlyGeneratedSquaresSetsItsAmountOfSquaresCorrectly [

	| board squares |
	squares := SquareGenerator
		           creating: 100
		           of: { 
				           AtomicBombSquare.
				           HyperJumpSquare.
				           MoonWalkSquare.
				           SpeedUpSquare.
				           WormHoleSquare.
				           BlankSquare }
		           with: { 
				           (2 / 100).
				           (8 / 100).
				           (1 / 10).
				           (2 / 10).
				           (2 / 10).
				           (4 / 10) }.
	board := Board madeUpBy: squares stretchedIntoLightYears: 200.


	self assert: [ board length = 100 ]
]
