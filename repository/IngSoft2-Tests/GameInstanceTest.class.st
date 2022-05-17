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

{ #category : #'tests - state asserting' }
GameInstanceTest >> testAskingForGameStateWhenFinishedReturnsFinished [

	| game aShip aDiceCup aBoard |
	aShip := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 5 dividedIn: 5 from: {}.
	aDiceCup := DiceCup with: (LoadedDie with: 6).
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        endLap: 1.

	game playNextTurn.

	self assert: [ game isFinished ]
]

{ #category : #'tests - state asserting' }
GameInstanceTest >> testAskingForGameStateWhenStartedReturnsStarted [

	| game aShip aDiceCup aBoard |
	aShip := Spaceship new.
	aBoard := Board sized: 10 dividedIn: 10 from: {}.
	aDiceCup := DiceCup with: (LoadedDie with: 7).
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        endLap: 1.
		
	game playNextTurn.

	self assert: [ game isStarted ]
]

{ #category : #'tests - winner' }
GameInstanceTest >> testAskingForWinnerWhenGameStillHasNotFinishedIsInvalid [

	|game board aSpaceship die |
	board := Board sized: 10 dividedIn: 10 from: {}.
	aSpaceship := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 7.
	game := TrenchRunGameInstance withParticipating: {aSpaceship} rolling: die on: board endLap: 1.
	
	
	self 
		should: [ game winner ]
		raise: Error 
		withMessage: 'There cannot be a winner if the game has not finished'.
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testBlankSlotHasNoEffect [

	|aGame spaceship dice board|
	dice := LoadedDie with: 5.
	board := Board sized: 10 dividedIn: 10 from: {}.
	spaceship := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance withParticipating: { spaceship } rolling: dice on: board endLap: 1.
	
	aGame playNextTurn.
	
	self assert: (aGame squareOf: spaceship) equals: 6.
	self assert: (aGame lapOf: spaceship) equals: 1.
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testHyperJumpMovesPlayersInDescendingOrderOfSequenceGiven [
	
	| game ship die board |
	ship := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 1.
	board := Board sized: 10 dividedIn: 20 from: ({2 -> (HyperJumpSlot with: {3 . 4}). 5 -> (HyperJumpSlot with: {1 . 2})} asDictionary ).
	game := TrenchRunGameInstance withParticipating: {ship}  rolling: die on: board endLap: 1.
	
	game playNextTurn.
	self assert: ((game squareOf: ship) = 4 and: [ (game lapOf: ship) = 1]).
	
	game playNextTurn.
	self assert: ((game squareOf: ship) = 6 and: [ (game lapOf: ship) = 1]).
]

{ #category : #'tests - positions' }
GameInstanceTest >> testMultipleShipsPositionsOnceGameIsFinished [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame winner |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 8.
	aBoard := Board sized: 10 dividedIn: 10 from: {}.
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

{ #category : #'tests - winner' }
GameInstanceTest >> testOneShippedGameCanOnlyKnowWinnerOnceGameIsFinished [

	| aShip aBoard aGame aLoadedDie winner |
	aShip := Spaceship named: 'Enterprise'.
	aLoadedDie := LoadedDie with: 11.
	aBoard := Board sized: 10 dividedIn: 10 from: {}.
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

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testShipCannotStartAnotherTurnOnceGameHasFinished [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 15.
	aBoard := Board sized: 10 dividedIn: 10 from: {}.
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

{ #category : #'tests - positions' }
GameInstanceTest >> testSpaceshipCompletingALapActuallyCountsIntoPositionTracker [

	| game aShip aDiceCup aBoard |
	aShip := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 5 dividedIn: 5 from: {}.
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

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartedGamePlaysUntilOneSpaceshipWins [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 dividedIn: 10 from: {}.
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
	aBoard := Board sized: 10 dividedIn: 10 from: {}.
	aDiceCup := DiceCup with: (LoadedDie with: 7).
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        endLap: 1.
		
	game playNextTurn.

	self assert: game isStarted
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithTwoOrMoreSpaceshipsIsValid [

	| game aFirstShip aSecondShip aDiceCup aBoard |
	aFirstShip := Spaceship named: 'Planet Express'.
	aSecondShip := Spaceship named: 'Enterprise'.
	aDiceCup := DiceCup with: (LoadedDie with: 5).
	aBoard := Board sized: 10 dividedIn: 10 from: {}.
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

{ #category : #'tests - winner' }
GameInstanceTest >> testTwoShippedGameCanOnlyKnowWinnerOnceGameIsFinished [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aLoadedDie aGame aBoard winner |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aBoard := Board sized: 10 dividedIn: 10 from: {}.
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

{ #category : #'tests - winner' }
GameInstanceTest >> testWinnerOfFixedMatchMatchesPositionsTable [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame positions |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board sized: 10 dividedIn: 10 from: {}.
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

{ #category : #'tests - winner' }
GameInstanceTest >> testWinnerOfFixedMatchMatchesRanking [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame positions |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board sized: 10 dividedIn: 10 from: {}.
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

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testWormHoleSlotBackTracksFourSquares [

	|aGame spaceship dice board|
	dice := LoadedDie with: 8.
	board := Board sized: 10 dividedIn: 10 from: (Dictionary newFromPairs: {9. WormHoleSlot new}).
	spaceship := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance withParticipating: { spaceship } rolling: dice on: board endLap: 1.
	
	aGame playNextTurn.
	
	self assert: (aGame squareOf: spaceship) equals: 5.
	self assert: (aGame lapOf: spaceship) equals: 1.
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testWormHoleSlotBackTracksToSquareOneIfSpaceshipIsOnLapOneAndSquareIsNotGreaterThanFour [

	|aGame spaceship dice board|
	dice := LoadedDie with: 1.
	board := Board sized: 10 dividedIn: 10 from: (Dictionary newFromPairs: {2. WormHoleSlot new}).
	spaceship := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance withParticipating: { spaceship } rolling: dice on: board endLap: 1.
	
	aGame playNextTurn.
	
	self assert: (aGame squareOf: spaceship) equals: 1.
	self assert: (aGame lapOf: spaceship) equals: 1.
]
