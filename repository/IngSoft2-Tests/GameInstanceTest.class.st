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

	| game aShip aDiceCup aBoard |
	aShip := Spaceship named: 'Enterprise'.
	aBoard := Board blankSized: 5.
	aDiceCup := DiceCup with: (LoadedDie with: 6).
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        endLap: 1.

	game playNextTurn.

	self assert: [ game isFinished ]
]

{ #category : #tests }
GameInstanceTest >> testAskingForGameStateWhenStartedReturnsStarted [

	| game aShip aDiceCup aBoard |
	aShip := Spaceship new.
	aBoard := Board blankSized: 10.
	aDiceCup := DiceCup with: (LoadedDie with: 7).
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        endLap: 1.
		
	game playNextTurn.

	self assert: [ game isStarted ]
]

{ #category : #tests }
GameInstanceTest >> testAskingForWinnerWhenGameStillHasNotFinishedIsInvalid [

	|game board aSpaceship die |
	board := Board sized: 10.
	aSpaceship := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 7.
	game := TrenchRunGameInstance withParticipating: {aSpaceship} rolling: die on: board endLap: 1.
	
	
	self 
		should: [ game winner ]
		raise: Error 
		withMessage: 'There cannot be a winner if the game has not finished'.
]

{ #category : #tests }
GameInstanceTest >> testMultipleShipsPositionsOnceGameIsFinished [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame winner |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 8.
	aBoard := Board blankSized: 10.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian.
				         aSpaceshipNamedHernan }
		         rolling: aLoadedDie
		         on: aBoard
		         endLap: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	winner := aGame winner.

	self assert: [ aGame isFinished and: (winner name match: 'Jorge') ]
]

{ #category : #tests }
GameInstanceTest >> testOneShippedGameCanOnlyKnowWinnerOnceGameIsFinished [

	| aShip aBoard aGame aLoadedDie winner |
	aShip := Spaceship named: 'Enterprise'.
	aLoadedDie := LoadedDie with: 11.
	aBoard := Board blankSized: 10.
	aGame := TrenchRunGameInstance
		         withParticipating: { aShip }
		         rolling: aLoadedDie
		         on: aBoard
		         endLap: 1.

	aGame playNextTurn.
	winner := aGame winner.

	self assert:
		(aGame isFinished and: (winner name match: 'Enterprise'))
]

{ #category : #tests }
GameInstanceTest >> testShipCannotStartAnotherTurnOnceGameHasFinished [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 15.
	aBoard := Board blankSized: 10.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian.
				         aSpaceshipNamedHernan }
		         rolling: aLoadedDie
		         on: aBoard
					endLap: 1.

	aGame playNextTurn.

	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'Cannot start another turn in a finished game'
]

{ #category : #tests }
GameInstanceTest >> testSpaceshipCompletingALapActuallyCountsIntoPositionTracker [

	| game aShip aDiceCup aBoard |
	aShip := Spaceship named: 'Enterprise'.
	aBoard := Board blankSized: 5.
	aDiceCup := DiceCup with: (LoadedDie with: 8).
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        endLap: 2.

	game playNextTurn.

	self assert:
		((game lapOf: aShip) = 2 and: [ (game squareOf: aShip) = 4 ])
]

{ #category : #tests }
GameInstanceTest >> testStartedGamePlaysUntilOneSpaceshipWins [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board blankSized: 10.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian }
		         rolling: aLoadedDie
		         on: aBoard
		         endLap: 1.

	[ aGame isFinished ] whileFalse: [ 
		aGame playNextTurn.
		aGame isFinished ifFalse: [ aGame playNextTurn ] ].

	self assert: (aGame isFinished and: [ aGame winner name match: 'Jorge' ])
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithOneSpaceshipIsValid [

	| game aShip aDiceCup aBoard |
	aShip := Spaceship new.
	aBoard := Board blankSized: 10.
	aDiceCup := DiceCup with: (LoadedDie with: 7).
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        endLap: 1.
		
	game playNextTurn.

	self assert: game isStarted
]

{ #category : #tests }
GameInstanceTest >> testStartingGameWithTwoOrMoreSpaceshipsIsValid [

	| game aFirstShip aSecondShip aDiceCup aBoard |
	aFirstShip := Spaceship named: 'Planet Express'.
	aSecondShip := Spaceship named: 'Enterprise'.
	aDiceCup := DiceCup with: (LoadedDie with: 5).
	aBoard := Board blankSized: 10.
	game := TrenchRunGameInstance
		        withParticipating: { 
				        aFirstShip.
				        aSecondShip }
		        rolling: aDiceCup
		        on: aBoard
		        endLap: 1.

	game playNextTurn.
	game playNextTurn.

	self assert: [ game isStarted ]
]

{ #category : #tests }
GameInstanceTest >> testTwoShippedGameCanOnlyKnowWinnerOnceGameIsFinished [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aLoadedDie aGame aBoard winner |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aBoard := Board blankSized: 10.
	aLoadedDie := LoadedDie with: 6.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian }
		         rolling: aLoadedDie
		         on: aBoard 
		         endLap: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	winner := aGame winner.

	self assert: (aGame isFinished and: (winner name match: 'Jorge'))
]

{ #category : #tests }
GameInstanceTest >> testWinnerOfFixedMatchMatchesPositionsTable [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame positions |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board blankSized: 10.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian }
		         rolling: aLoadedDie
		         on: aBoard
		         endLap: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	positions := aGame positions.

	self assert: (aGame isFinished and: [ 
			 (aGame winner name match: 'Jorge') and: [ 
				 (aGame squareOf: aSpaceshipNamedJorge) = 1 and: [ 
					 (aGame lapOf: aSpaceshipNamedJorge) = 2 ] ] ])
]

{ #category : #tests }
GameInstanceTest >> testWinnerOfFixedMatchMatchesRanking [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame positions |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board blankSized: 10.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian }
		         rolling: aLoadedDie
		         on: aBoard
		         endLap: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	positions := aGame positions.

	self assert: (aGame isFinished and: [ 
			 (aGame winner name match: 'Jorge') and: [ (aGame ranking at: 1) match: 'Jorge' ]]).
]
