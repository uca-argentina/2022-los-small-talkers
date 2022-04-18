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
	state := GameStateFinished new.
	self assert: (state printState) equals: 'finished'.
]

{ #category : #'tests - GameNotStarted' }
GameStateTest >> testGameStateNotStartedReturnsNotStartedWhenCalledForGameState [
	|state|
	state := GameStateNotStarted new.
	self assert: (state printState) equals: 'not started'.
]

{ #category : #'tests - GameStarted' }
GameStateTest >> testGameStateStartedReturnsStartedWhenAskedForGameState [
	|state|
	state := GameStateStarted new.
	self assert: (state printState) equals: 'started'.
]
