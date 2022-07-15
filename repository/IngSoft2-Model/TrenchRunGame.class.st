Class {
	#name : #TrenchRunGame,
	#superclass : #Object,
	#instVars : [
		'dice',
		'gameBoard',
		'state',
		'positionTracker',
		'endingLap',
		'deck',
		'onHandCardStack',
		'playedCardStack',
		'history',
		'spaceshipSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrenchRunGame class >> withParticipating: spaceships rolling: aDiceCup on: aBoard until: endLap using: aDeck [

	^ self new
		  initializeWithParticipating: spaceships
		  rolling: aDiceCup
		  on: aBoard
		  until: endLap
		  using: aDeck
]

{ #category : #'accessing - positions' }
TrenchRunGame >> currentLeader [

	^ positionTracker currentLeader
]

{ #category : #'card playing' }
TrenchRunGame >> currentPlayer [

	^ spaceshipSequence previous
]

{ #category : #private }
TrenchRunGame >> end [
	state := Finished new.
]

{ #category : #'card playing' }
TrenchRunGame >> give: cardType toHandsOf: spaceship [

	onHandCardStack give: cardType toHandsOf: spaceship
]

{ #category : #initialization }
TrenchRunGame >> initializeWithParticipating: spaceships rolling: aDiceCup on: aBoard until: endLap using: aDeck [

	deck := aDeck.
	gameBoard := aBoard.
	dice := aDiceCup.
	state := Started new.
	endingLap := endLap.
	positionTracker := PositionTracker tracking: spaceships.
	onHandCardStack := OnHandCardStack new.
	playedCardStack := PlayedPermanentCardStack new.
	spaceships do: [ :spaceship | self take: 2 andGiveToHandsOf: spaceship].
	history := TrenchRunEventList new.
	spaceshipSequence := TrenchRunSequence withAll: spaceships
]

{ #category : #'asserting state' }
TrenchRunGame >> isFinished [

	^ state isFinished.
]

{ #category : #'asserting state' }
TrenchRunGame >> isStarted [

	^ state isStarted
]

{ #category : #'accessing - positions' }
TrenchRunGame >> lapOf: aShip [

	^ (self positionOf: aShip) lap
]

{ #category : #'applying effects' }
TrenchRunGame >> lastLandsOnSquareEvent [
	^ history lastLandsOnSquareEvent square.
]

{ #category : #accessing }
TrenchRunGame >> lastPlayedCard [

	^ history lastPlayCardEvent card
]

{ #category : #'turn related' }
TrenchRunGame >> move: ship anAmountOf: squares [

	| currentLap nextLap currentSquare nextSquare |
	currentSquare := self squareOf: ship.
	currentLap := self lapOf: ship.
	nextSquare := currentSquare + squares \\ gameBoard length.
	nextSquare = 0 ifTrue: [ nextSquare := 1 ].
	nextLap := currentLap
	           +
	           (currentSquare + squares - nextSquare / gameBoard length).

	nextLap < 1 ifTrue: [ 
		nextLap := 1.
		nextSquare := 1 ].

	nextLap > endingLap
		ifTrue: [ 
			positionTracker move: ship at: 1 after: endingLap + 1.
			self end ]
		ifFalse: [ positionTracker move: ship at: nextSquare after: nextLap ]
]

{ #category : #'turn related' }
TrenchRunGame >> move: spaceship by: aNumberOfParsecs [

	self move: spaceship anAmountOf: (aNumberOfParsecs / gameBoard parsecsPerSquare)
]

{ #category : #'turn related' }
TrenchRunGame >> moveAllSpaceshipToSquareOne [
	(self spaceships) do: [ :aSpaceship | self move: aSpaceship anAmountOf: (1 - (self squareOf: aSpaceship)) ]
]

{ #category : #'turn related' }
TrenchRunGame >> moveAllSpaceshipsAnAmountOf: squares exceptFor: aSpaceship [
	|spaceshipsToMove|
	spaceshipsToMove := self spaceships.
	spaceshipsToMove remove: aSpaceship.
	spaceshipsToMove do: [ :spaceship | self move: spaceship anAmountOf: (0 - squares) ].
]

{ #category : #'card playing' }
TrenchRunGame >> playAccelerationCardOwnedBy: aSpaceship [

	onHandCardStack take: AccelerationCard fromHandsOf: aSpaceship.
	history add: ((AccelerationCard ownedBy: aSpaceship)
		a: aSpaceship
		playsCardIn: self
		aimingAt: self spaceships)
]

{ #category : #'card playing' }
TrenchRunGame >> playCancellationCardOwnedBy: aSpaceship aimingAt: aPlayedPermanentCard [

	onHandCardStack take: CancellationCard fromHandsOf: aSpaceship.
	history add: ((CancellationCard ownedBy: aSpaceship)
			a: aSpaceship
			playsCardIn: self
			aimingAt: aPlayedPermanentCard)
]

{ #category : #'turn related' }
TrenchRunGame >> playNextTurn [

	| squaresForward ship |
	ship := spaceshipSequence next.
	state update: self.
	squaresForward := playedCardStack
		                  applyEffectsTo: ship
		                  using: dice roll.
	self move: ship anAmountOf: squaresForward.
	self isFinished ifFalse: [ 
		history add:
			(gameBoard applyEffectAt: (self squareOf: ship) to: ship on: self) ]
]

{ #category : #'card playing' }
TrenchRunGame >> playOverloadCardOwnedBy: aSpaceship aimingAt: anotherSpaceship [

	onHandCardStack take: OverloadCard fromHandsOf: aSpaceship.
	history add: ((OverloadCard ownedBy: aSpaceship)
			 a: aSpaceship
			 playsCardIn: self
			 aimingAt: anotherSpaceship)
]

{ #category : #'card playing' }
TrenchRunGame >> playRedoCardOwnedBy: aSpaceship aimingAt: anotherSpaceship [

	onHandCardStack take: RedoCard fromHandsOf: aSpaceship.
	history add: ((RedoCard ownedBy: aSpaceship ) a: aSpaceship playsCardIn: self aimingAt: anotherSpaceship)
]

{ #category : #'card playing' }
TrenchRunGame >> playRepeatCardOwnedBy: aSpaceship aimingAt: anotherSpaceship [

	onHandCardStack take: RepeatCard fromHandsOf: aSpaceship.
	history add: ((RepeatCard ownedBy: aSpaceship)
		a: aSpaceship
		playsCardIn: self
		aimingAt: anotherSpaceship)
]

{ #category : #'card playing' }
TrenchRunGame >> playSpeedCardOwnedBy: aSpaceship aimingAt: anotherSpaceship [

	onHandCardStack take: SpeedCard fromHandsOf: aSpaceship.
	history add: ((SpeedCard ownedBy: aSpaceship)
		a: aSpaceship
		playsCardIn: self
		aimingAt: anotherSpaceship)
]

{ #category : #accessing }
TrenchRunGame >> playedCardStack [

	^playedCardStack 
]

{ #category : #private }
TrenchRunGame >> positionOf: aShip [

	^ positionTracker positionOf: aShip ifAbsent: [  ]
]

{ #category : #'accessing - positions' }
TrenchRunGame >> positions [ 

	^positionTracker positions.
]

{ #category : #'accessing - positions' }
TrenchRunGame >> ranking [

	| rankingSize |
	rankingSize := 3 min: self positions size.

	^ Dictionary
		  newFromKeys: (1 to: rankingSize by: 1)
		  andValues: (self positions
				   collect: [ :position | position ship ]
				   from: 1
				   to: rankingSize)
]

{ #category : #accessing }
TrenchRunGame >> spaceships [ 

	^ positionTracker spaceships.
]

{ #category : #'accessing - positions' }
TrenchRunGame >> squareOf: aShip [

	^ (self positionOf: aShip) square
]

{ #category : #'turn related' }
TrenchRunGame >> take: anAmountOfCards andGiveToHandsOf: aSpaceship [
	
	|cards|
	cards := deck take: anAmountOfCards.
	cards do: [ :card | onHandCardStack give: card toHandsOf: aSpaceship ].

	
]

{ #category : #'accessing - positions' }
TrenchRunGame >> winner [

	^ state winner: self
]
