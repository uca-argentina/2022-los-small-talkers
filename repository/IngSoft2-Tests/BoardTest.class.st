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
		should: [ Board sized: -5 dividedInParsecs: 10 from: {  } ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereLightYearsLowerOrEqualToZeroIsInvalid [

	self
		should: [ Board sized: 10 dividedInLightYears: 0 from: {  } ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'.

	self
		should: [ Board sized: 10 dividedInLightYears: -10 from: {  } ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereParsecsLowerOrEqualToZeroIsInvalid [

	self
		should: [ Board sized: 10 dividedInParsecs: 0 from: {  } ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'.

	self
		should: [ Board sized: 10 dividedInParsecs: -10 from: {  } ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'
]

{ #category : #tests }
BoardTest >> testBoardDistanceInLightYearsIsThreeTimesAsMuchAsInParsecs [

	| board |
	board := Board
		         sized: 1
		         dividedInParsecs: 10
		         from: { BlankSquare new }.
	self
		assert: board lightYearsPerSquare
		equals: board parsecsPerSquare * 3
]

{ #category : #tests }
BoardTest >> testRandomBoardCreationThrowsNoErrors [

	| board squares|
	squares := SquareGenerator 
								creating: 100 
								of: { AtomicBombSquare . HyperJumpSquare . MoonWalkSquare . SpeedUpSquare . WormHoleSquare . BlankSquare } 
								with: { 2/100. 8/100. 1/10. 2/10. 2/10. 4/10 }.
	board := Board sized: 100 dividedInParsecs: 200 from: squares.

	
	self assert: [ (board length) = 100  ]
]
