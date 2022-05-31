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

	| game enterprise aDiceCup aBoard |
	enterprise := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 5 dividedIn: 5 from: {  }.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	game := TrenchRunGameInstance
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.

	self assert: [ game isFinished ]
]

{ #category : #'tests - state asserting' }
GameInstanceTest >> testAskingForGameStateWhenStartedReturnsStarted [

	| game enterprise aDiceCup aBoard |
	enterprise := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 7) }.
	game := TrenchRunGameInstance
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.

	self assert: [ game isStarted ]
]

{ #category : #'tests - winner' }
GameInstanceTest >> testAskingForWinnerWhenGameStillHasNotFinishedIsInvalid [

	| game board enterprise die |
	board := Board sized: 10 dividedIn: 10 from: {  }.
	enterprise := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 7.
	game := TrenchRunGameInstance
		        withParticipating: { enterprise }
		        rolling: die
		        on: board
		        until: 1.


	self
		should: [ game winner ]
		raise: Error
		withMessage: 'There cannot be a winner if the game has not finished'
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testAtomicBombSlotResetsPositionsToOneButMaintainsNumberOfLaps [

	| aGame enterprise board starfighter explorer aDie anAtomicBombSlot slots |
	aDie := LoadedDie with: 15.
	anAtomicBombSlot := AtomicBombSlot new.
	slots := Dictionary newFromPairs: { 
			         6.
			         anAtomicBombSlot.
			         1.
			         BlankSlot new }.
	board := Board sized: 10 dividedIn: 10 from: slots.
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	explorer := Spaceship named: 'Explorer'.
	aGame := TrenchRunGameInstance
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

	| aGame enterprise dice board |
	dice := LoadedDie with: 5.
	board := Board sized: 10 dividedIn: 10 from: {  }.
	enterprise := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance
		         withParticipating: { enterprise }
		         rolling: dice
		         on: board
		         until: 1.

	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 6.
	self assert: (aGame lapOf: enterprise) equals: 1
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testHyperJumpMovesPlayersInDescendingOrderOfSequenceGiven [

	| game enterprise die board |
	enterprise := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 1.
	board := Board sized: 10 dividedIn: 20 from: { 
			         (2
			          ->
			          (HyperJumpSlot with: { ('M' -> { 3. 4 }) } asDictionary)).
			         (5
			          ->
			          (HyperJumpSlot with: { ('M' -> { 1. 2 }) } asDictionary)) }
			         asDictionary.
	game := TrenchRunGameInstance
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

	| aGame enterprise board starfighter explorer aDie aMoonwalkSlot slots |
	aDie := LoadedDie with: 3.
	aMoonwalkSlot := MoonWalkSlot with: { ('N' -> 1) } asDictionary.
	slots := Dictionary newFromPairs: { 
			         7.
			         aMoonwalkSlot.
			         4.
			         BlankSlot new }.
	board := Board sized: 10 dividedIn: 10 from: slots.
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	explorer := Spaceship named: 'Explorer'.
	aGame := TrenchRunGameInstance
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

	| enterprise starfighter explorer aBoard aLoadedDie aGame winner |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	explorer := Spaceship named: 'Explorer'.
	aLoadedDie := LoadedDie with: 8.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
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

	| enterprise aBoard aGame aLoadedDie winner |
	enterprise := Spaceship named: 'Enterprise'.
	aLoadedDie := LoadedDie with: 11.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
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

	| enterprise starfighter explorer aBoard aLoadedDie aGame |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	explorer := Spaceship named: 'Explorer'.
	aLoadedDie := LoadedDie with: 15.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
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

	| game enterprise die board |
	enterprise := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 500.
	board := Board
		         sized: 10
		         dividedIn: 200
		         from: { (1 -> WormHoleSlot new) } asDictionary.
	game := TrenchRunGameInstance
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

	| game enterprise aDiceCup aBoard |
	enterprise := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 5 dividedIn: 5 from: {  }.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 8) }.
	game := TrenchRunGameInstance
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

	| aGame enterprise dice board slots |
	dice := LoadedDie with: 3.
	slots := Dictionary newFromPairs: { 
			         4.
			         SpeedUpSlot new.
			         1.
			         BlankSlot new }.
	board := Board sized: 10 dividedIn: 10 from: slots.
	enterprise := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance
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

	| enterprise starfighter aBoard aLoadedDie aGame |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
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
GameInstanceTest >> testStartingGameWithOneSpaceshipIsValid [

	| game enterprise aDiceCup aBoard |
	enterprise := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 7) }.
	game := TrenchRunGameInstance
		        withParticipating: { enterprise }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.

	self assert: game isStarted
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithTwoOrMoreSpaceshipsIsValid [

	| game starfighter enterprise aDiceCup aBoard |

	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 5) }.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	game := TrenchRunGameInstance
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

	| enterprise starfighter aLoadedDie aGame aBoard winner |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aLoadedDie := LoadedDie with: 6.
	aGame := TrenchRunGameInstance
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

	| enterprise starfighter aBoard aLoadedDie aGame positions |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
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

	| enterprise starfighter aBoard aLoadedDie aGame positions |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	aLoadedDie := LoadedDie with: 6.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
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

	| aGame enterprise dice board |
	dice := LoadedDie with: 8.
	board := Board
		         sized: 10
		         dividedIn: 10
		         from: (Dictionary newFromPairs: { 
					          9.
					          WormHoleSlot new }).
	enterprise := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance
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

	| aGame enterprise dice board |
	dice := LoadedDie with: 1.
	enterprise := Spaceship named: 'Enterprise'.
	board := Board
		         sized: 10
		         dividedIn: 10
		         from: (Dictionary newFromPairs: { 
					          2.
					          WormHoleSlot new }).
	aGame := TrenchRunGameInstance
		         withParticipating: { enterprise }
		         rolling: dice
		         on: board
		         until: 1.

	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 1.
	self assert: (aGame lapOf: enterprise) equals: 1
]
