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
RandomSquareGeneratorTest >> testRandomSquareGeneratorCannotBeCreatedWithMAmountMissing [

	| rsgBlock |
	rsgBlock := [ 
	            RandomSquaresGenerator
		            creating: { BlankSlot }
		            with: { 1 }
		            sized: { 4 }
		            accordingTo: { 
				            ('Nmax' -> 1).
				            ('Mmax' -> 1) } asDictionary ].

	self
		should: rsgBlock
		raise: Error
		withMessage: 'Missing Mamount on creation parameters'
]

{ #category : #tests }
RandomSquareGeneratorTest >> testRandomSquareGeneratorCannotBeCreatedWithMMaxMissing [

	| rsgBlock |
	rsgBlock := [ 
	            RandomSquaresGenerator
		            creating: { BlankSlot }
		            with: { 1 }
		            sized: { 4 }
		            accordingTo: { 
				            ('Nmax' -> 1).
				            ('Mamount' -> 1) } asDictionary ].

	self
		should: rsgBlock
		raise: Error
		withMessage: 'Missing Mmax on creation parameters'
]

{ #category : #tests }
RandomSquareGeneratorTest >> testRandomSquareGeneratorCannotBeCreatedWithNMaxMissing [

	| rsgBlock |
	rsgBlock := [ 
	            RandomSquaresGenerator
		            creating: { BlankSlot }
		            with: { 1 }
		            sized: { 4 }
		            accordingTo: { 
				            ('Mmax' -> 1).
				            ('Mamount' -> 1) } asDictionary ].

	self
		should: rsgBlock
		raise: Error
		withMessage: 'Missing Nmax on creation parameters'
]

{ #category : #tests }
RandomSquareGeneratorTest >> testRandomSquareGeneratorCannotBeCreatedWithProbabilitiesSummingDifferentToOne [

	| rsgBlock |
	rsgBlock := [ 
	            RandomSquaresGenerator
		            creating: { BlankSlot }
		            with: { 2 }
		            sized: { 4 }
		            accordingTo: { 
				            ('Nmax' -> 1).
				            ('Mmax' -> 1).
				            ('Mamount' -> 1) } asDictionary ].

	self
		should: rsgBlock
		raise: Error
		withMessage: 'Sum of probabilities differ from 1'
]
