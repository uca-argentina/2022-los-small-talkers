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
BoardTest >> testBoardCreationWhereLengthEqualsZeroIsInvalid [

	self
		should: [ Board sized: 0 dividedIn: 10 ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereLengthLowerThanZeroIsInvalid [

	self
		should: [ Board sized: -5 dividedIn: 10 ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'
]

{ #category : #tests }
BoardTest >> testBoardCreationWhereParsecsLowerOrEqualToZeroIsInvalid [

	self
		should: [ Board sized: 10 dividedIn: 0 ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'.

	self
		should: [ Board sized: 10 dividedIn: -10 ]
		raise: Error
		withMessage: 'Boards need a minimum length of 1'
]

{ #category : #tests }
BoardTest >> testCreatingABoardWithRandomSquares [

	| board |
	board := Board sized: 200 dividedIn: 200.
	board length
]
