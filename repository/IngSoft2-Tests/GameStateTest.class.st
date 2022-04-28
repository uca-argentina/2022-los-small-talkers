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
GameStateTest >> testGameStateFinishedReturnsFinishedWhenCalledForGameState [
	|state|
	state := Finished new.
	self assert: [state isStarted not].
]

{ #category : #'tests - GameStarted' }
GameStateTest >> testGameStateStartedReturnsStartedWhenAskedForGameState [
	|state|
	state := Started new.
	self assert: [state isStarted].
]
