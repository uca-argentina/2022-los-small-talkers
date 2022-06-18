Class {
	#name : #CardGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
CardGeneratorTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^ self
		  should: aBlock
		  raise: anErrorType
		  whoseDescriptionIncludes: anErrorMessage
		  description: 'Test did not fail for expected reason'
]

{ #category : #tests }
CardGeneratorTest >> testCardGeneratorCannotBeCreatedWithProbabilitiesSummingDifferentToOne [

	self
		should: [ 
		Gen_CardGenerator creating: 10 of: { SpeedCard } with: { 1.5 } ]
		raise: Error
		withMessage: 'Sum of probabilities differ from 1'
]

{ #category : #tests }
CardGeneratorTest >> testCardGeneratorCreatesOneHundredSpeedCards [

	| cards |
	cards := Gen_CardGenerator creating: 100 of: { SpeedCard } with: { 1 }.

	self assert: cards size equals: 100.
	cards do: [ :card | self assert: card className equals: 'SpeedCard class' ]
]
