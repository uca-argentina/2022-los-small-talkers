Class {
	#name : #SquareGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
SquareGeneratorTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^ self
		  should: aBlock
		  raise: anErrorType
		  whoseDescriptionIncludes: anErrorMessage
		  description: 'Test did not fail for expected reason'
]

{ #category : #tests }
SquareGeneratorTest >> testSquareGeneratorCannotBeCreatedWithProbabilitiesSummingDifferentToOne [

	self
		should: [ Gen_SquareGenerator creating: 10 of: { BlankSquare } with: { 1.5 } ]
		raise: Error
		withMessage: 'Sum of probabilities differ from 1'
]

{ #category : #tests }
SquareGeneratorTest >> testSquareGeneratorCreatesOneHundredBlankSquares [

	|squares|
	squares := Gen_SquareGenerator creating: 100 of: { BlankSquare } with: { 1 }.
	
	self assert: squares size equals: 100.
	squares do: [ :square | self assert: (square className match: 'BlankSquare') ]
]
