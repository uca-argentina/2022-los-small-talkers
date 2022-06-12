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

	| game enterprise aDiceCup aBoard squares|
	enterprise := Spaceship named: 'Enterprise'.
	squares := RandomObjectGenerator creating: 5 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 5 dividedIn: 5 from: squares.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.

	self assert: [ game isFinished ]
]

{ #category : #'tests - state asserting' }
GameInstanceTest >> testAskingForGameStateWhenStartedReturnsStarted [

	| game enterprise aDiceCup aBoard squares|
	enterprise := Spaceship named: 'Enterprise'.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 10 dividedIn: 10 from: squares.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 7) }.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.

	self assert: [ game isStarted ]
]

{ #category : #'tests - winner' }
GameInstanceTest >> testAskingForWinnerWhenGameStillHasNotFinishedIsInvalid [

	| game aBoard enterprise die squares|
	squares := RandomObjectGenerator creating: 5 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 5 dividedIn: 5 from: squares.
	enterprise := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 7.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: die
		        on: aBoard
		        until: 1.


	self
		should: [ game winner ]
		raise: Error
		withMessage: 'There cannot be a winner if the game has not finished'
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testAtomicBombSlotResetsPositionsToOneButMaintainsNumberOfLaps [

	| aGame enterprise board starfighter explorer aDie squares|
	aDie := LoadedDie with: 15.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }.
	squares at: 6 put: AtomicBombSquare new. 
	board := Board sized: 10 dividedIn: 10 from: squares.
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	explorer := Spaceship named: 'Explorer'.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter.
				         explorer }
		         rolling: aDie
		         on: board
		         until: 3.


	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 1.
	self assert: (aGame lapOf: enterprise) equals: 2.
	self assert: (aGame squareOf: starfighter) equals: 1.
	self assert: (aGame lapOf: starfighter) equals: 2.
	self assert: (aGame squareOf: explorer) equals: 1.
	self assert: (aGame lapOf: explorer) equals: 2
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testBlankSlotHasNoEffect [

	| aGame enterprise dice board squares|
	dice := LoadedDie with: 5.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	board := Board sized: 10 dividedIn: 10 from: squares.
	enterprise := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGame
		         withParticipating: { enterprise }
		         rolling: dice
		         on: board
		         until: 1.

	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 6.
	self assert: (aGame lapOf: enterprise) equals: 1
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testGameWithOneSpaceshipIsStartedOnceFirstHandIsPlayed [

	| game enterprise aDiceCup aBoard squares|
	enterprise := Spaceship named: 'Enterprise'.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 10 dividedIn: 10 from: squares.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 7) }.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.

	self assert: game isStarted
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testHyperJumpMovesPlayersInDescendingOrderOfSequenceGiven [

	| game enterprise die board squares|
	enterprise := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 1.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	squares at: 2 put: (HyperJumpSquare with: {3. 4}).
	squares at: 5 put: (HyperJumpSquare with: {1. 2}).
	board := Board sized: 10 dividedIn: 20 from: squares.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: die
		        on: board
		        until: 1.

	game playNextTurn.
	self assert:
		((game squareOf: enterprise) = 4 and: [ (game lapOf: enterprise) = 1 ]).

	game playNextTurn.
	self assert:
		((game squareOf: enterprise) = 6 and: [ (game lapOf: enterprise) = 1 ])
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testMoonWalkSlotBackTracksEverySpaceshipAnAmountOfSquaresExceptFromTheShipPlayingTheirTurn [

	| aGame enterprise board starfighter explorer aDie squares|
	aDie := LoadedDie with: 3.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }.
	squares at: 7 put: (MoonWalkSquare with: 1).
	board := Board sized: 10 dividedIn: 10 from: squares.
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	explorer := Spaceship named: 'Explorer'.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter.
				         explorer }
		         rolling: aDie
		         on: board
		         until: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 7.
	self assert: (aGame lapOf: enterprise) equals: 1.
	self assert: (aGame squareOf: starfighter) equals: 3.
	self assert: (aGame lapOf: starfighter) equals: 1.
	self assert: (aGame squareOf: explorer) equals: 3.
	self assert: (aGame lapOf: explorer) equals: 1
]

{ #category : #'tests - positions' }
GameInstanceTest >> testMultipleShipsPositionsOnceGameIsFinished [

	| enterprise starfighter explorer aBoard aLoadedDie aGame winner squares|
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	explorer := Spaceship named: 'Explorer'.
	aLoadedDie := LoadedDie with: 8.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 10 dividedIn: 10 from: squares.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter.
				         explorer }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	winner := aGame winner.

	self assert: [ aGame isFinished and: (winner name match: 'Enterprise') ]
]

{ #category : #'tests - winner' }
GameInstanceTest >> testOneShippedGameCanOnlyKnowWinnerOnceGameIsFinished [

	| enterprise aBoard aGame aLoadedDie winner squares|
	enterprise := Spaceship named: 'Enterprise'.
	aLoadedDie := LoadedDie with: 11.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 10 dividedIn: 10 from: squares.
	aGame := TrenchRunGame
		         withParticipating: { enterprise }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

	aGame playNextTurn.
	winner := aGame winner.

	self assert:
		(aGame isFinished and: (winner name match: 'Enterprise'))
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testShipCannotStartAnotherTurnOnceGameHasFinished [

	| enterprise starfighter explorer aBoard aLoadedDie aGame squares|
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	explorer := Spaceship named: 'Explorer'.
	aLoadedDie := LoadedDie with: 15.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 10 dividedIn: 10 from: squares.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter.
				         explorer }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

	aGame playNextTurn.

	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'Cannot start another turn in a finished game'
]

{ #category : #tests }
GameInstanceTest >> testSlotDoesNotActivateWhenSomeoneStepsOnFirstSlotOfMaximumLapPlusOne [

	| game enterprise die board squares|
	enterprise := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 500.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }.
	squares at: 10 put: WormHoleSquare new.
	board := Board
		         sized: 10
		         dividedIn: 200
		         from: squares.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: die
		        on: board
		        until: 1.
	game playNextTurn.

	self assert: (game winner name = enterprise name and: [ 
			 (game squareOf: enterprise) = 1 and: [ (game lapOf: enterprise) = 2 ] ])
]

{ #category : #'tests - positions' }
GameInstanceTest >> testSpaceshipCompletingALapActuallyCountsIntoPositionTracker [

	| game enterprise aDiceCup aBoard squares|
	enterprise := Spaceship named: 'Enterprise'.
	squares := RandomObjectGenerator creating: 5 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 5 dividedIn: 5 from: squares.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 8) }.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 2.

	game playNextTurn.

	self assert:
		((game lapOf: enterprise) = 2 and: [ (game squareOf: enterprise) = 4 ])
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testSpeedUpSlotForwardTracksFourSquares [

	| aGame enterprise dice board squares|
	dice := LoadedDie with: 3.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }.
	squares at: 4 put: SpeedUpSquare new.
	board := Board sized: 10 dividedIn: 10 from: squares.
	enterprise := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGame
		         withParticipating: { enterprise }
		         rolling: dice
		         on: board
		         until: 1.

	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 8.
	self assert: (aGame lapOf: enterprise) equals: 1
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartedGamePlaysUntilOneSpaceshipWins [

	| enterprise starfighter aBoard aLoadedDie aGame squares|
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	aLoadedDie := LoadedDie with: 4.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 10 dividedIn: 10 from: squares.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

	[ aGame isFinished ] whileFalse: [ 
		aGame playNextTurn.
		aGame isFinished ifFalse: [ aGame playNextTurn ] ].

	self assert:
		(aGame isFinished and: [ aGame winner name match: 'Enterprise' ])
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithTwoOrMoreSpaceshipsIsValid [

	| game starfighter enterprise aDiceCup aBoard squares|

	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 5) }.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 10 dividedIn: 10 from: squares.
	game := TrenchRunGame
		        withParticipating: { 
				        starfighter.
				        enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.
	game playNextTurn.

	self assert: [ game isStarted ]
]

{ #category : #'tests - winner' }
GameInstanceTest >> testTwoShippedGameCanOnlyKnowWinnerOnceGameIsFinished [

	| enterprise starfighter aLoadedDie aGame aBoard winner squares|
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 10 dividedIn: 10 from: squares.
	aLoadedDie := LoadedDie with: 6.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	winner := aGame winner.

	self assert: (aGame isFinished and: (winner name match: 'Enterprise'))
]

{ #category : #'tests - winner' }
GameInstanceTest >> testWinnerOfFixedMatchMatchesPositionsTable [

	| enterprise starfighter aBoard aLoadedDie aGame positions squares|
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	aLoadedDie := LoadedDie with: 6.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 10 dividedIn: 10 from: squares.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	positions := aGame positions.

	self assert: (aGame isFinished and: [ 
			 (aGame winner name match: 'Enterprise') and: [ 
				 (aGame squareOf: enterprise) = 1 and: [ 
					 (aGame lapOf: enterprise) = 2 ] ] ])
]

{ #category : #'tests - winner' }
GameInstanceTest >> testWinnerOfFixedMatchMatchesRanking [

	| enterprise starfighter aBoard aLoadedDie aGame positions squares|
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	aLoadedDie := LoadedDie with: 6.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	aBoard := Board sized: 10 dividedIn: 10 from: squares.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	positions := aGame positions.

	self assert: (aGame isFinished and: [ 
			 (aGame winner name match: 'Enterprise') and: [ 
				 (aGame ranking at: 1) match: 'Enterprise' ] ])
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testWormHoleSlotBackTracksFourSquares [

	| aGame enterprise dice board squares|
	dice := LoadedDie with: 8.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	squares at: 9 put: WormHoleSquare new.
	board := Board
		         sized: 10
		         dividedIn: 10
		         from: squares.
	enterprise := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGame
		         withParticipating: { enterprise }
		         rolling: dice
		         on: board
		         until: 1.

	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 5.
	self assert: (aGame lapOf: enterprise) equals: 1
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testWormHoleSlotBackTracksToSquareOneIfSpaceshipIsOnLapOneAndSquareIsNotGreaterThanFour [

	| aGame enterprise dice board squares|
	dice := LoadedDie with: 1.
	enterprise := Spaceship named: 'Enterprise'.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }. 
	squares at: 2 put: WormHoleSquare new.
	board := Board
		         sized: 10
		         dividedIn: 10
		         from: squares .
	aGame := TrenchRunGame
		         withParticipating: { enterprise }
		         rolling: dice
		         on: board
		         until: 1.

	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 1.
	self assert: (aGame lapOf: enterprise) equals: 1
]
