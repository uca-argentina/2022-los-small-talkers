Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^self 
		should: aBlock 
		raise: anErrorType  
		whoseDescriptionIncludes: anErrorMessage  
		description: 'Test did not fail for expected reason'
]

{ #category : #'RandomDie - tests' }
GameTest >> testLoadedDieRollsAlwaysNumberOnLoadedSide [
	self assert: [ (LoadedDie with: 4) roll == 4].
]

{ #category : #'RandomDie - tests' }
GameTest >> testLoadedDieWithZeroOrNegativeLoadedSideIsInvalid [
	
self 
	should: [ LoadedDie with: 0 ] 
	raise: Error 
	withMessage: 'Loaded side cannot be negative nor zero'.
]

{ #category : #'RandomDie - tests' }
GameTest >> testRandomDieRollsNumberBetweenOneAndItself [
	| result |
	result := (RandomDie with: 6) roll.
	
	self assert: [result between: 1 and: 6].
]

{ #category : #'RandomDie - tests' }
GameTest >> testRandomDieWithNumberOfSidesFewerThan3IsInvalid [

	self
		should: [ RandomDie with:  -3 ]
		raise: Error
		withMessage: 'Number of sides must be greater than 2'
]

{ #category : #'RandomDie - tests' }
GameTest >> testRandomDieWithNumberOfSidesGreaterThanTwoIsValid [
	
	| aRandomDie |
	aRandomDie := RandomDie with: 3
]
