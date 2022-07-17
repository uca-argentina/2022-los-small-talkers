Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^self 
		should: aBlock 
		raise: anErrorType  
		whoseDescriptionIncludes: anErrorMessage  
		description: 'Test did not fail for expected reason'
]

{ #category : #tests }
DieTest >> testAddingADieWithADiceCupTogetherMakesADiceCupWithItsMaximumBeingTheSumOfBothMaximums [

	| sixSidedDie diceCupWithTwoEightSidedDice |
	sixSidedDie := Die with: 6.
	diceCupWithTwoEightSidedDice := DiceCup withAll: { 
			                                (Die with: 8).
			                                (Die with: 8) }.

	self
		assert: (diceCupWithTwoEightSidedDice + sixSidedDie) maxResult
		equals:
		diceCupWithTwoEightSidedDice maxResult + sixSidedDie maxResult 
]

{ #category : #tests }
DieTest >> testAddingTwoDiceTogetherMakesADiceCupWithItsMaximumBeingTheSumOfBothDicesMaximums [

	| sixSidedDie eightSidedDie |
	sixSidedDie := Die with: 6.
	eightSidedDie := Die with: 8.
	
	self assert: (sixSidedDie + eightSidedDie) maxResult equals: sixSidedDie maxResult + eightSidedDie maxResult.
	
]

{ #category : #'tests - DiceCup' }
DieTest >> testCreatingDiceCupWithOnlyOneDiceIsValid [

	| aDiceCup |
	aDiceCup := DiceCup withAll: { (LoadedDie with: 10) }.
	self assert: aDiceCup roll equals: 10
]

{ #category : #'tests - DiceCup' }
DieTest >> testCreatingDiceCupWithTwoDiceIsValid [

	| aDiceCup aFirstDice aSecondDice |
	aFirstDice := Die with: 5.
	aSecondDice := Die with: 7.
	aDiceCup := DiceCup withAll: { 
			            aFirstDice.
			            aSecondDice }.

	self assert: (aDiceCup roll between: 2 and: 12)
]

{ #category : #'tests - DiceCup' }
DieTest >> testDiceCupRollsSumOfAllIndividualDiceRollsResultsInsideIt [

	| aFirstDie aSecondDie aThirdDie aDiceCup sumOfAllDiceRolls |
	aFirstDie := LoadedDie with: 7.
	aSecondDie := LoadedDie with: 8.
	aThirdDie := LoadedDie with: 9.
	aDiceCup := DiceCup withAll: { 
			            aFirstDie.
			            aSecondDie.
			            aThirdDie }.

	sumOfAllDiceRolls := { 
		                     aFirstDie roll.
		                     aSecondDie roll.
		                     aThirdDie roll } sum.

	self assert: aDiceCup roll equals: sumOfAllDiceRolls
]

{ #category : #'tests - LoadedDie' }
DieTest >> testLoadedDieRollsAlwaysNumberOnLoadedSide [

	self assert: [ (LoadedDie with: 4) roll == 4 ]
]

{ #category : #'tests - LoadedDie' }
DieTest >> testLoadedDieWithZeroOrNegativeLoadedSideIsInvalid [

	self
		should: [ LoadedDie with: 0 ]
		raise: Error
		withMessage: 'Loaded side cannot be negative nor zero'
]

{ #category : #'tests - RandomDie' }
DieTest >> testRandomDieRollsNumberBetweenOneAndItself [

	| result |
	result := (Die with: 6) roll.

	self assert: [ result between: 1 and: 6 ]
]

{ #category : #'tests - RandomDie' }
DieTest >> testRandomDieWithNumberOfSidesFewerThan3IsInvalid [

	self
		should: [ Die with: -3 ]
		raise: Error
		withMessage: 'Number of sides must be greater than 2'
]

{ #category : #'tests - RandomDie' }
DieTest >> testRandomDieWithNumberOfSidesGreaterThanTwoIsValid [

	| aRandomDie |
	aRandomDie := Die with: 3
]
