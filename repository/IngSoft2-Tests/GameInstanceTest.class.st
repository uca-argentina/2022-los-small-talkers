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

{ #category : #tests }
GameInstanceTest >> testAskingForGameStateWhenFinishedReturnsFinished [
	|game aShip aDiceCup aBoard|
	aShip := Spaceship new.
	aBoard := Board sized: 5.
	aDiceCup := DiceCup with:(LoadedDie with: 10).
	game := GameInstance withShip: aShip diceCup: aDiceCup board: aBoard.
	aShip startTurn.
	
	self assert: (game printState) equals: 'finished'.
]

{ #category : #tests }
GameInstanceTest >> testAskingForGameStateWhenNotStartedReturnsNotStarted [
	self shouldBeImplemented.
]


{ #category : #tests }
GameInstanceTest >> testAskingForGameStateWhenStartedReturnsStarted [
	self shouldBeImplemented.
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
