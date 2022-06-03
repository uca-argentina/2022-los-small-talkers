Class {
	#name : #RandomSquareGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
RandomSquareGeneratorTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^ self
		  should: aBlock
		  raise: anErrorType
		  whoseDescriptionIncludes: anErrorMessage
		  description: 'Test did not fail for expected reason'
]

{ #category : #tests }
RandomSquareGeneratorTest >> testRandomSquareGeneratorCannotBeCreatedWithProbabilitiesSummingDifferentToOne [

	self
		should: [ RandomSquaresGenerator creating: 10 of: { BlankSquare } with: { 1.5 } ]
		raise: Error
		withMessage: 'Sum of probabilities differ from 1'
]

{ #category : #tests }
RandomSquareGeneratorTest >> testRandomSquareGeneratorCreatesOneHundredBlankSquares [

	|squareGenerator squares|
	squareGenerator := RandomSquaresGenerator creating: 100 of: { BlankSquare } with: { 1 }.
	squares := squareGenerator generateSquares.
	
	self assert: squares size equals: 100.
	squares do: [ :square | self assert: (square className match: 'BlankSquare') ]
]
