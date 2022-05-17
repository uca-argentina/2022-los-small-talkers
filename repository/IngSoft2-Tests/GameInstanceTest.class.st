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
	aBoard := Board sized: 5 dividedIn: 5 from: {  }.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 6) }.
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.

	self assert: [ game isFinished ]
]

{ #category : #'tests - state asserting' }
GameInstanceTest >> testAskingForGameStateWhenStartedReturnsStarted [

	| game aShip aDiceCup aBoard |
	aShip := Spaceship new.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 7) }.
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.

	self assert: [ game isStarted ]
]

{ #category : #'tests - winner' }
GameInstanceTest >> testAskingForWinnerWhenGameStillHasNotFinishedIsInvalid [

	| game board aSpaceship die |
	board := Board sized: 10 dividedIn: 10 from: {  }.
	aSpaceship := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 7.
	game := TrenchRunGameInstance
		        withParticipating: { aSpaceship }
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

	| aGame spaceship board aSpaceship anotherSpaceship aDie anAtomicBombSlot slots |
	aDie := LoadedDie with: 15.
	anAtomicBombSlot := AtomicBombSlot new.
	slots := Dictionary newFromPairs: { 
			         6.
			         anAtomicBombSlot.
			         1.
			         BlankSlot new }.
	board := Board sized: 10 dividedIn: 10 from: slots.
	spaceship := Spaceship named: 'Enterprise'.
	aSpaceship := Spaceship named: 'Starfighter'.
	anotherSpaceship := Spaceship named: 'Explorer'.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         spaceship.
				         aSpaceship.
				         anotherSpaceship }
		         rolling: aDie
		         on: board
		         until: 3.


	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame squareOf: spaceship) equals: 1.
	self assert: (aGame lapOf: spaceship) equals: 2.
	self assert: (aGame squareOf: aSpaceship) equals: 1.
	self assert: (aGame lapOf: aSpaceship) equals: 2.
	self assert: (aGame squareOf: anotherSpaceship) equals: 1.
	self assert: (aGame lapOf: anotherSpaceship) equals: 2
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testBlankSlotHasNoEffect [

	| aGame spaceship dice board |
	dice := LoadedDie with: 5.
	board := Board sized: 10 dividedIn: 10 from: {  }.
	spaceship := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance
		         withParticipating: { spaceship }
		         rolling: dice
		         on: board
		         until: 1.

	aGame playNextTurn.

	self assert: (aGame squareOf: spaceship) equals: 6.
	self assert: (aGame lapOf: spaceship) equals: 1
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testHyperJumpMovesPlayersInDescendingOrderOfSequenceGiven [

	| game ship die board |
	ship := Spaceship named: 'Enterprise'.
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
		        withParticipating: { ship }
		        rolling: die
		        on: board
		        until: 1.

	game playNextTurn.
	self assert:
		((game squareOf: ship) = 4 and: [ (game lapOf: ship) = 1 ]).

	game playNextTurn.
	self assert:
		((game squareOf: ship) = 6 and: [ (game lapOf: ship) = 1 ])
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testMoonWalkSlotBackTracksEverySpaceshipAnAmountOfSquaresExceptFromTheShipPlayingTheirTurn [

	| aGame spaceship board aSpaceship anotherSpaceship aDie aMoonwalkSlot slots |
	aDie := LoadedDie with: 3.
	aMoonwalkSlot := MoonWalkSlot with: { ('N' -> 1) } asDictionary.
	slots := Dictionary newFromPairs: { 
			         7.
			         aMoonwalkSlot.
			         4.
			         BlankSlot new }.
	board := Board sized: 10 dividedIn: 10 from: slots.
	spaceship := Spaceship named: 'Enterprise'.
	aSpaceship := Spaceship named: 'Starfighter'.
	anotherSpaceship := Spaceship named: 'Explorer'.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         spaceship.
				         aSpaceship.
				         anotherSpaceship }
		         rolling: aDie
		         on: board
		         until: 1.


	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame squareOf: spaceship) equals: 7.
	self assert: (aGame lapOf: spaceship) equals: 1.
	self assert: (aGame squareOf: aSpaceship) equals: 3.
	self assert: (aGame lapOf: aSpaceship) equals: 1.
	self assert: (aGame squareOf: anotherSpaceship) equals: 3.
	self assert: (aGame lapOf: anotherSpaceship) equals: 1
]

{ #category : #'tests - positions' }
GameInstanceTest >> testMultipleShipsPositionsOnceGameIsFinished [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame winner |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 8.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian.
				         aSpaceshipNamedHernan }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

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
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
		         withParticipating: { aShip }
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

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aSpaceshipNamedHernan aBoard aLoadedDie aGame |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aSpaceshipNamedHernan := Spaceship named: 'Hernan'.
	aLoadedDie := LoadedDie with: 15.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian.
				         aSpaceshipNamedHernan }
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

	| game ship die board |
	ship := Spaceship named: 'Enterprise'.
	die := LoadedDie with: 500.
	board := Board
		         sized: 10
		         dividedIn: 200
		         from: { (1 -> WormHoleSlot new) } asDictionary.
	game := TrenchRunGameInstance
		        withParticipating: { ship }
		        rolling: die
		        on: board
		        until: 1.
	game playNextTurn.

	self assert: (game winner name = ship name and: [ 
			 (game squareOf: ship) = 1 and: [ (game lapOf: ship) = 2 ] ])
]

{ #category : #'tests - positions' }
GameInstanceTest >> testSpaceshipCompletingALapActuallyCountsIntoPositionTracker [

	| game aShip aDiceCup aBoard |
	aShip := Spaceship named: 'Enterprise'.
	aBoard := Board sized: 5 dividedIn: 5 from: {  }.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 8) }.
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        until: 2.

	game playNextTurn.

	self assert:
		((game lapOf: aShip) = 2 and: [ (game squareOf: aShip) = 4 ])
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testSpeedUpSlotForwardTracksFourSquares [

	| aGame spaceship dice board slots |
	dice := LoadedDie with: 3.
	slots := Dictionary newFromPairs: { 
			         4.
			         SpeedUpSlot new.
			         1.
			         BlankSlot new }.
	board := Board sized: 10 dividedIn: 10 from: slots.
	spaceship := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance
		         withParticipating: { spaceship }
		         rolling: dice
		         on: board
		         until: 1.

	aGame playNextTurn.

	self assert: (aGame squareOf: spaceship) equals: 8.
	self assert: (aGame lapOf: spaceship) equals: 1
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartedGamePlaysUntilOneSpaceshipWins [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aBoard aLoadedDie aGame |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aLoadedDie := LoadedDie with: 4.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

	[ aGame isFinished ] whileFalse: [ 
		aGame playNextTurn.
		aGame isFinished ifFalse: [ aGame playNextTurn ] ].

	self assert:
		(aGame isFinished and: [ aGame winner name match: 'Jorge' ])
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithOneSpaceshipIsValid [

	| game aShip aDiceCup aBoard |
	aShip := Spaceship new.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 7) }.
	game := TrenchRunGameInstance
		        withParticipating: { aShip }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.

	self assert: game isStarted
]

{ #category : #'tests - starting game checks' }
GameInstanceTest >> testStartingGameWithTwoOrMoreSpaceshipsIsValid [

	| game aFirstShip aSecondShip aDiceCup aBoard |
	aFirstShip := Spaceship named: 'Planet Express'.
	aSecondShip := Spaceship named: 'Enterprise'.
	aDiceCup := DiceCup withAll: { (LoadedDie with: 5) }.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	game := TrenchRunGameInstance
		        withParticipating: { 
				        aFirstShip.
				        aSecondShip }
		        rolling: aDiceCup
		        on: aBoard
		        until: 1.

	game playNextTurn.
	game playNextTurn.

	self assert: [ game isStarted ]
]

{ #category : #'tests - winner' }
GameInstanceTest >> testTwoShippedGameCanOnlyKnowWinnerOnceGameIsFinished [

	| aSpaceshipNamedJorge aSpaceshipNamedJulian aLoadedDie aGame aBoard winner |
	aSpaceshipNamedJorge := Spaceship named: 'Jorge'.
	aSpaceshipNamedJulian := Spaceship named: 'Julian'.
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aLoadedDie := LoadedDie with: 6.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

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
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

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
	aBoard := Board sized: 10 dividedIn: 10 from: {  }.
	aGame := TrenchRunGameInstance
		         withParticipating: { 
				         aSpaceshipNamedJorge.
				         aSpaceshipNamedJulian }
		         rolling: aLoadedDie
		         on: aBoard
		         until: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	positions := aGame positions.

	self assert: (aGame isFinished and: [ 
			 (aGame winner name match: 'Jorge') and: [ 
				 (aGame ranking at: 1) match: 'Jorge' ] ])
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testWormHoleSlotBackTracksFourSquares [

	| aGame spaceship dice board |
	dice := LoadedDie with: 8.
	board := Board
		         sized: 10
		         dividedIn: 10
		         from: (Dictionary newFromPairs: { 
					          9.
					          WormHoleSlot new }).
	spaceship := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance
		         withParticipating: { spaceship }
		         rolling: dice
		         on: board
		         until: 1.

	aGame playNextTurn.

	self assert: (aGame squareOf: spaceship) equals: 5.
	self assert: (aGame lapOf: spaceship) equals: 1
]

{ #category : #'tests - slot functionality' }
GameInstanceTest >> testWormHoleSlotBackTracksToSquareOneIfSpaceshipIsOnLapOneAndSquareIsNotGreaterThanFour [

	| aGame spaceship dice board |
	dice := LoadedDie with: 1.
	board := Board
		         sized: 10
		         dividedIn: 10
		         from: (Dictionary newFromPairs: { 
					          2.
					          WormHoleSlot new }).
	spaceship := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance
		         withParticipating: { spaceship }
		         rolling: dice
		         on: board
		         until: 1.

	aGame playNextTurn.

	self assert: (aGame squareOf: spaceship) equals: 1.
	self assert: (aGame lapOf: spaceship) equals: 1
]
