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
	
	|aGame aLoadedDie aBoard aSpaceship1 aGameState|

	aLoadedDie := LoadedDie with: 4.
	aSpaceship1 := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 5 withSpaceships: {aSpaceship1}.
	
	aGame := GameInstance withShip: {aSpaceship1} diceCup: aLoadedDie board: aBoard.
	aGame end.
	
	
	aGameState := aGame state printState.
	
	self assert: [ aGameState match: 'finished' ].
]

{ #category : #'tests - GameNotStarted' }
GameStateTest >> testGameNotStartedStateReturnsNotStartedWhenCalledForGameState [
	|aGame aLoadedDie aBoard aSpaceship1 aGameState|

	aLoadedDie := LoadedDie with: 4.
	aSpaceship1 := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 5 withSpaceships: {aSpaceship1}.
	
	aGame := GameInstance withShip: {aSpaceship1} diceCup: aLoadedDie board: aBoard.
	
	aGameState := aGame state printState.
	
	self assert: [ aGameState match: 'not started' ].	
]

{ #category : #'tests - GameStarted' }
GameStateTest >> testGameStartedStateReturnsStartedWhenAskedForGameState [
	|aGame aLoadedDie aBoard aSpaceship1 aGameState|

	aLoadedDie := LoadedDie with: 4.
	aSpaceship1 := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 5 withSpaceships: {aSpaceship1}.
	
	aGame := GameInstance withShip: {aSpaceship1} diceCup: aLoadedDie board: aBoard.
	
	aGame start.
	
	aGameState := aGame state printState.
	
	self assert: [ aGameState match: 'started' ].	
]
