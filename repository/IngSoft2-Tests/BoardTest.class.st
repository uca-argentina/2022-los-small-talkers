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
