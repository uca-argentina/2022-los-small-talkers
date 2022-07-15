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
		should: [ 
		Board madeUpBy: {  } stretchedInto: (Parsec amounting: 10) ]
		raise: Error
		withMessage: 'Boards needs at least one square'
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereLightYearsLowerOrEqualToZeroIsInvalid [

	self
		should: [ 
			Board
				madeUpBy: { BlankSquare }
				stretchedInto: (LightYear amounting: 0) ]
		raise: Error
		withMessage: 'Board distance cannot be zero'.

	self
		should: [ 
			Board
				madeUpBy: { BlankSquare }
				stretchedInto: (LightYear amounting: -10) ]
		raise: Error
		withMessage: 'LightYears cannot amount to a negative number'
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereParsecsLowerOrEqualToZeroIsInvalid [

	self
		should: [ Board madeUpBy: { BlankSquare } stretchedInto: (Parsec amounting: 0) ]
		raise: Error
		withMessage: 'Board distance cannot be zero'.

	self
		should: [ Board madeUpBy: { BlankSquare } stretchedInto: (Parsec amounting: -10) ]
		raise: Error
		withMessage: 'Parsecs cannot amount to a negative number'
]

{ #category : #tests }
BoardTest >> testBoardDistancedInLightYearsCanGiveItsLengthAccuratelyInParsecs [

	| board |
	board := Board
		         madeUpBy: { BlankSquare }
		         stretchedInto: (LightYear amounting: 10).
	self
		assert: board distanceInLightYears
		equals: board distanceInParsecs * 3.

	self
		assert: board lightYearsPerSquare
		equals: board parsecsPerSquare * 3
]

{ #category : #tests }
BoardTest >> testBoardDistancedInParsecsCanGiveItsLengthAccuratelyInLightYears [

	| board |
	board := Board
		         madeUpBy: { BlankSquare }
		         stretchedInto: (Parsec amounting: 10).
	self
		assert: board distanceInLightYears
		equals: board distanceInParsecs * 3.

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
	board := Board madeUpBy: squares stretchedInto: (LightYear amounting: 200).


	self assert: [ board length = 100 ]
]
