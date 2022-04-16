Class {
	#name : #GameStateTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameStateTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^self 
		should: aBlock 
		raise: anErrorType  
		whoseDescriptionIncludes: anErrorMessage  
		description: 'Test did not fail for expected reason'
]

{ #category : #'tests - GameFinished' }
GameStateTest >> testGameFinishedStateReturnsFinishedWhenCalledForGameState [

	self shouldBeImplemented.
]

{ #category : #'tests - GameNotStarted' }
GameStateTest >> testGameNotStartedStateReturnsNotStartedWhenCalledForGameState [

	self shouldBeImplemented.
]

{ #category : #'tests - GameStarted' }
GameStateTest >> testGameStartedStateReturnsStartedWhenAskedForGameState [

	self shouldBeImplemented.
]
