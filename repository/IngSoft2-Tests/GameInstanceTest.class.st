Class {
	#name : #GameInstanceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameInstanceTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^self 
		should: aBlock 
		raise: anErrorType  
		whoseDescriptionIncludes: anErrorMessage  
		description: 'Test did not fail for expected reason'
]

{ #category : #'tests - adding game parameters' }
GameInstanceTest >> testAddingBoardWhenGameHasAlreadyStartedIsInvalid [

	self shouldBeImplemented .
]

{ #category : #'tests - adding game parameters' }
GameInstanceTest >> testAddingBoardWhenGameHasNotStartedIsValid [

	self shouldBeImplemented.
]

{ #category : #'tests - adding game parameters' }
GameInstanceTest >> testAddingDiceWhenGameHasAlreadyStartedIsInvalid [

	self shouldBeImplemented .
]

{ #category : #'tests - adding game parameters' }
GameInstanceTest >> testAddingDiceWhenGameHasNotStartedIsValid [
	
	self shouldBeImplemented.
]

{ #category : #'tests - spaceship registering' }
GameInstanceTest >> testRegisteringOneSpaceshipWhenGameHasAlreadyStartedIsInvalid [

	self shouldBeImplemented.
]

{ #category : #'tests - spaceship registering' }
GameInstanceTest >> testRegisteringOneSpaceshipWhenGameHasNotStartedIsValid [

	self shouldBeImplemented.
]

{ #category : #'tests - spaceship registering' }
GameInstanceTest >> testRegisteringOneSpaceshipWhenThereIsNoBoardIsInvalid [ 

	self shouldBeImplemented .
]

{ #category : #'tests - spaceship registering' }
GameInstanceTest >> testRegisteringTwoSpaceshipsWhenGameHasAlreadyStartedIsInvalid [

	self shouldBeImplemented .
]

{ #category : #'tests - spaceship registering' }
GameInstanceTest >> testRegisteringTwoSpaceshipsWhenGameHasNotStartedIsValid [

	self shouldBeImplemented .
]

{ #category : #'tests - spaceship registering' }
GameInstanceTest >> testRegisteringTwoSpaceshipsWhenThereIsNoBoardIsInvalid [ 

	self shouldBeImplemented .
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithNoBoardIsInvalid [

	self shouldBeImplemented.
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithNoDiceIsInvalid [

	self shouldBeImplemented .
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithNoSpaceshipsIsInvalid [

	self shouldBeImplemented .
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithOneSpaceshipIsValid [

	self shouldBeImplemented .
]
