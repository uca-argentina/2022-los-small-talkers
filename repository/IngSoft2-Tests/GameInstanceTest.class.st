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

	| game enterprise aDiceCup aBoard squares deck |
	enterprise := 'Enterprise'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { SpeedCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1
		        using: deck.

	game playNextTurn.

	self assert: [ game isFinished ]
]

{ #category : #'tests - state asserting' }
GameInstanceTest >> testAskingForGameStateWhenStartedReturnsStarted [

	| game enterprise aDiceCup aBoard squares deck |
	enterprise := 'Enterprise'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 7) }.
	deck := Deck handingOver: { SpeedCard }.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1
		        using: deck.

	game playNextTurn.

	self assert: [ game isStarted ]
]

{ #category : #'tests - winner' }
GameInstanceTest >> testAskingForWinnerWhenGameStillHasNotFinishedIsInvalid [

	| game aBoard enterprise die squares deck |
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
	enterprise := 'Enterprise'.
	die := LoadedDie with: 7.
	deck := Deck handingOver: { SpeedCard }.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: die
		        on: aBoard
		        until: 1
		        using: deck.


	self
		should: [ game winner ]
		raise: Error
		withMessage: 'There cannot be a winner if the game has not finished'
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testAtomicBombSlotResetsPositionsToOneButMaintainsNumberOfLaps [

	| aGame enterprise board starfighter explorer aDie squares deck |
	aDie := LoadedDie with: 15.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 6 put: AtomicBombSquare new.
	deck := Deck handingOver: { SpeedCard }.
	board := Board madeUpBy: squares stretchedIntoParsecs: 10.
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	explorer := 'Explorer'.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter.
				         explorer }
		         rolling: aDie
		         on: board
		         until: 3
		         using: deck.


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

	| aGame enterprise dice board squares deck |
	dice := LoadedDie with: 5.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	board := Board madeUpBy: squares stretchedIntoParsecs: 10.
	enterprise := 'Enterprise'.
	deck := Deck handingOver: { SpeedCard }.
	aGame := TrenchRunGame
		         withParticipating: { enterprise }
		         rolling: dice
		         on: board
		         until: 1
		         using: deck.

	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 6.
	self assert: (aGame lapOf: enterprise) equals: 1
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testGameWithOneSpaceshipIsStartedOnceFirstHandIsPlayed [

	| game enterprise aDiceCup aBoard squares deck |
	enterprise := 'Enterprise'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 7) }.
	deck := Deck handingOver: { SpeedCard }.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1
		        using: deck.

	game playNextTurn.

	self assert: game isStarted
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testHyperJumpCanMovePlayersInLightYears [

	| game enterprise die board squares |
	enterprise := 'Enterprise'.
	die := LoadedDie with: 1.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: (HyperJumpSquare withLightYears: { 3. 4 }).
	squares at: 5 put: (HyperJumpSquare withLightYears: { 1. 2 }).
	board := Board madeUpBy: squares stretchedIntoLightYears: 20.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: die
		        on: board
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).

	game playNextTurn.
	self assert:
		((game squareOf: enterprise) = 4 and: [ 
			 (game lapOf: enterprise) = 1 ]).

	game playNextTurn.
	self assert:
		((game squareOf: enterprise) = 6 and: [ 
			 (game lapOf: enterprise) = 1 ])
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testHyperJumpMovesPlayersInDescendingOrderOfSequenceGiven [

	| game enterprise die board squares |
	enterprise := 'Enterprise'.
	die := LoadedDie with: 1.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: (HyperJumpSquare withParsecs: { 3. 4 }).
	squares at: 5 put: (HyperJumpSquare withParsecs: { 1. 2 }).
	board := Board madeUpBy: squares stretchedIntoParsecs: 20.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: die
		        on: board
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).

	game playNextTurn.
	self assert:
		((game squareOf: enterprise) = 4 and: [ 
			 (game lapOf: enterprise) = 1 ]).

	game playNextTurn.
	self assert:
		((game squareOf: enterprise) = 6 and: [ 
			 (game lapOf: enterprise) = 1 ])
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testMoonWalkSlotBackTracksEverySpaceshipAnAmountOfSquaresExceptFromTheShipPlayingTheirTurn [

	| aGame enterprise board starfighter explorer aDie squares |
	aDie := LoadedDie with: 3.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: (MoonWalkSquare with: 1).
	board := Board madeUpBy: squares stretchedIntoParsecs: 10.
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	explorer := 'Explorer'.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter.
				         explorer }
		         rolling: aDie
		         on: board
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).

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

	| enterprise starfighter explorer aBoard aLoadedDie aGame winner squares |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	explorer := 'Explorer'.
	aLoadedDie := LoadedDie with: 8.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter.
				         explorer }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	winner := aGame winner.

	self assert: [ 
		aGame isFinished and: (winner match: 'Enterprise') ]
]

{ #category : #'tests - winner' }
GameInstanceTest >> testOneShippedGameCanOnlyKnowWinnerOnceGameIsFinished [

	| enterprise aBoard aGame aLoadedDie winner squares |
	enterprise := 'Enterprise'.
	aLoadedDie := LoadedDie with: 11.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
	aGame := TrenchRunGame
		         withParticipating: { enterprise }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).

	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There cannot be a winner if the game has not finished'.
		
	aGame playNextTurn.
	winner := aGame winner.

	self assert:
		(aGame isFinished and: (winner match: 'Enterprise'))
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testShipCannotStartAnotherTurnOnceGameHasFinished [

	| enterprise starfighter explorer aBoard aLoadedDie aGame squares |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	explorer := 'Explorer'.
	aLoadedDie := LoadedDie with: 15.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter.
				         explorer }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).

	aGame playNextTurn.

	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'Cannot start another turn in a finished game'
]

{ #category : #tests }
GameInstanceTest >> testSlotDoesNotActivateWhenSomeoneStepsOnFirstSlotOfMaximumLapPlusOne [

	| game enterprise die board squares |
	enterprise := 'Enterprise'.
	die := LoadedDie with: 500.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 10 put: WormHoleSquare new.
	board := Board madeUpBy: squares stretchedIntoParsecs: 200.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: die
		        on: board
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).
	game playNextTurn.

	self assert: (game winner = enterprise and: [ 
			 (game squareOf: enterprise) = 1 and: [ 
				 (game lapOf: enterprise) = 2 ] ])
]

{ #category : #'tests - positions' }
GameInstanceTest >> testSpaceshipCompletingALapActuallyCountsIntoPositionTracker [

	| game enterprise aDiceCup aBoard squares |
	enterprise := 'Enterprise'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 8) }.
	game := TrenchRunGame
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 2
		        using: (Deck handingOver: { SpeedCard }).

	game playNextTurn.

	self assert:
		((game lapOf: enterprise) = 2 and: [ 
			 (game squareOf: enterprise) = 4 ])
]

{ #category : #tests }
GameInstanceTest >> testSpaceshipPlayingOutOfTurnIsMovedTwoSquaresBackwards [

	| game enterprise die board squares starship |
	enterprise := 'Enterprise'.
	starship := 'Starship'.
	die := LoadedDie with: 3.
	squares := SquareGenerator
		           creating: 20
		           of: { BlankSquare }
		           with: { 1 }.
	board := Board madeUpBy: squares stretchedIntoLightYears: 20.
	game := TrenchRunGame
		        withParticipating: { enterprise. starship }
		        rolling: die
		        on: board
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).
	
	
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: starship.
	
	self assert: (game squareOf: enterprise) equals: 7.
	self assert: (game squareOf: starship) equals: 5.
]

{ #category : #tests }
GameInstanceTest >> testSpaceshipPlayingOutOfTurnIsMovedTwoSquaresBackwardsAndSquareHasNoEffect [

	| game enterprise die board squares starship |
	enterprise := 'Enterprise'.
	starship := 'Starship'.
	die := LoadedDie with: 3.
	squares := SquareGenerator
		           creating: 20
		           of: { BlankSquare }
		           with: { 1 }.
	board := Board madeUpBy: squares stretchedIntoLightYears: 20.
	game := TrenchRunGame
		        withParticipating: { enterprise. starship }
		        rolling: die
		        on: board
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).
	
	squares at: 5 put: SpeedUpSquare new.
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: starship.
	
	self assert: (game squareOf: enterprise) equals: 7.
	self assert: (game squareOf: starship) equals: 5.
]

{ #category : #tests }
GameInstanceTest >> testSpaceshipPlayingOutOfTurnIsNotEnabledToPlayNextTurn [

	| game enterprise die board squares starship penalizedShips |
	enterprise := 'Enterprise'.
	starship := 'Starship'.
	die := LoadedDie with: 3.
	squares := SquareGenerator
		           creating: 20
		           of: { BlankSquare }
		           with: { 1 }.
	board := Board madeUpBy: squares stretchedIntoLightYears: 20.
	game := TrenchRunGame
		        withParticipating: { enterprise. starship }
		        rolling: die
		        on: board
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).
	
	
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: starship.
	
	penalizedShips := game penalizedSpaceshipsStack.
	
	self deny: (penalizedShips checkEnabledToPlay: starship).
]

{ #category : #tests }
GameInstanceTest >> testSpaceshipPlayingOutOfTurnIsPenalizedAndThenCanPlayAgain [

	| game enterprise die board squares starship penalizedShips |
	enterprise := 'Enterprise'.
	starship := 'Starship'.
	die := LoadedDie with: 3.
	squares := SquareGenerator
		           creating: 20
		           of: { BlankSquare }
		           with: { 1 }.
	board := Board madeUpBy: squares stretchedIntoLightYears: 20.
	game := TrenchRunGame
		        withParticipating: { enterprise. starship }
		        rolling: die
		        on: board
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).
	
	
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: starship.
	
	penalizedShips := game penalizedSpaceshipsStack.
	penalizedShips canPlayAgain: starship.
	
	self assert: (penalizedShips checkEnabledToPlay: starship).
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testSpeedUpSlotForwardTracksFourSquares [

	| aGame enterprise dice board squares |
	dice := LoadedDie with: 3.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 4 put: SpeedUpSquare new.
	board := Board madeUpBy: squares stretchedIntoParsecs: 10.
	enterprise := 'Enterprise'.
	aGame := TrenchRunGame
		         withParticipating: { enterprise }
		         rolling: dice
		         on: board
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).

	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 8.
	self assert: (aGame lapOf: enterprise) equals: 1
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartedGamePlaysUntilOneSpaceshipWins [

	| enterprise starfighter aBoard aLoadedDie aGame squares |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	aLoadedDie := LoadedDie with: 4.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).

	[ aGame isFinished ] whileFalse: [ 
		aGame playNextTurn.
		aGame isFinished ifFalse: [ aGame playNextTurn ] ].

	self assert:
		(aGame isFinished and: [ aGame winner match: 'Enterprise' ])
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithTwoOrMoreSpaceshipsIsValid [

	| game starfighter enterprise aDiceCup aBoard squares |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 5) }.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
	game := TrenchRunGame
		        withParticipating: { 
				        starfighter.
				        enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).

	game playNextTurn.
	game playNextTurn.

	self assert: [ game isStarted ]
]

{ #category : #'tests - winner' }
GameInstanceTest >> testTwoShippedGameCanOnlyKnowWinnerOnceGameIsFinished [

	| enterprise starfighter aLoadedDie aGame aBoard winner squares |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
	aLoadedDie := LoadedDie with: 6.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).

	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There cannot be a winner if the game has not finished'.
		
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	winner := aGame winner.

	self assert:
		(aGame isFinished and: (winner match: 'Enterprise'))
]

{ #category : #'tests - winner' }
GameInstanceTest >> testWinnerOfFixedMatchMatchesPositionsTable [

	| enterprise starfighter aBoard aLoadedDie aGame positions squares |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	aLoadedDie := LoadedDie with: 6.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	positions := aGame positions.

	self assert: (aGame isFinished and: [ 
			 (aGame winner match: 'Enterprise') and: [ 
				 (aGame squareOf: enterprise) = 1 and: [ 
					 (aGame lapOf: enterprise) = 2 ] ] ])
]

{ #category : #'tests - winner' }
GameInstanceTest >> testWinnerOfFixedMatchMatchesRanking [

	| enterprise starfighter aBoard aLoadedDie aGame positions squares |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	aLoadedDie := LoadedDie with: 6.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	positions := aGame positions.

	self assert: (aGame isFinished and: [ 
			 (aGame winner match: 'Enterprise') and: [ 
				 (aGame ranking at: 1) match: 'Enterprise' ] ])
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testWormHoleSlotBackTracksFourSquares [

	| aGame enterprise dice board squares |
	dice := LoadedDie with: 8.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 9 put: WormHoleSquare new.
	board := Board madeUpBy: squares stretchedIntoParsecs: 10.
	enterprise := 'Enterprise'.
	aGame := TrenchRunGame
		         withParticipating: { enterprise }
		         rolling: dice
		         on: board
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).
		
	aGame playNextTurn.
	self assert: (aGame squareOf: enterprise) equals: 5.
	self assert: (aGame lapOf: enterprise) equals: 1
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testWormHoleSlotBackTracksToSquareOneIfSpaceshipIsOnLapOneAndSquareIsNotGreaterThanFour [

	| aGame enterprise dice board squares |
	dice := LoadedDie with: 1.
	enterprise := 'Enterprise'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: WormHoleSquare new.
	board := Board madeUpBy: squares stretchedIntoParsecs: 10.
	aGame := TrenchRunGame
		         withParticipating: { enterprise }
		         rolling: dice
		         on: board
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).

	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 1.
	self assert: (aGame lapOf: enterprise) equals: 1
]
