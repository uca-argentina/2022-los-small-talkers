Class {
	#name : #TrenchRunGame,
	#superclass : #Object,
	#instVars : [
		'dice',
		'gameBoard',
		'state',
		'positionTracker',
		'endingLap',
		'history',
		'turnHandler',
		'cardHandler',
		'jail'
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

{ #category : #accessing }
TrenchRunGame >> cardHandler [

	^ cardHandler
]

{ #category : #'card playing' }
TrenchRunGame >> cardPlayBy: aSpaceship using: aCard [

	"Method used for those cards that do not support a target argument."

	"If the card requires a target argument, then this method
	will raise an Error with the message '(Card) did not understand the message Card >> #isPlayedIn:' "

	cardHandler take: aCard fromHandsOf: aSpaceship.
	history add: ((aCard ownedBy: aSpaceship) isPlayedIn: self)
]

{ #category : #'card playing' }
TrenchRunGame >> cardPlayBy: aSpaceship using: aCard aimingAt: target [

	"Each card has its own interpretation of target."

	"Use this method only on those cards that accept a target argument.
	If they do not support a target argument, it will be discarded. (For now)"

	cardHandler take: aCard fromHandsOf: aSpaceship.
	history add:
		((aCard ownedBy: aSpaceship) isPlayedIn: self aimingAt: target)
]

{ #category : #private }
TrenchRunGame >> end [
	state := Finished new.
]

{ #category : #'card playing' }
TrenchRunGame >> give: cardType toHandsOf: spaceship [

	cardHandler give: cardType toHandsOf: spaceship
]

{ #category : #initialization }
TrenchRunGame >> initializeWithParticipating: spaceships rolling: aDiceCup on: aBoard until: endLap using: aDeck [

	gameBoard := aBoard.
	dice := aDiceCup.
	state := Started new.
	endingLap := endLap.
	jail := Jail new.
	positionTracker := PositionTracker tracking: spaceships.
	cardHandler := CardHandler withAll: spaceships drawingFrom: aDeck.
	history := TrenchRunEventList new.
	turnHandler := TurnHandler withParticipating: spaceships
]

{ #category : #'asserting state' }
TrenchRunGame >> isFinished [

	^ state isFinished.
]

{ #category : #'asserting state' }
TrenchRunGame >> isStarted [

	^ state isStarted
]

{ #category : #accessing }
TrenchRunGame >> jail [

^ jail
]

{ #category : #'applying effects' }
TrenchRunGame >> lastLandsOnSquareEvent [
	^ history lastLandsOnSquareEvent square.
]

{ #category : #accessing }
TrenchRunGame >> lastPlayedCard [

	^ history lastPlayCardEvent card class
]

{ #category : #'turn related' }
TrenchRunGame >> move: ship anAmountOf: squares [

	| currentLap nextLap currentSquare nextSquare |
	currentSquare := positionTracker squareOf: ship.
	currentLap := positionTracker lapOf: ship.
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
TrenchRunGame >> move: spaceship by: someDistance [

	self move: spaceship anAmountOf: (someDistance inParsecs / gameBoard parsecsPerSquare)
]

{ #category : #'turn related' }
TrenchRunGame >> moveAllSpaceshipToSquareOne [

	self spaceships do: [ :aSpaceship | 
		self
			move: aSpaceship
			anAmountOf: 1 - (positionTracker squareOf: aSpaceship) ]
]

{ #category : #'turn related' }
TrenchRunGame >> moveAllSpaceshipsAnAmountOf: squares exceptFor: aSpaceship [

	| spaceshipsToMove |
	spaceshipsToMove := self spaceships.
	spaceshipsToMove remove: aSpaceship.
	spaceshipsToMove do: [ :spaceship | 
		self move: spaceship anAmountOf: 0 - squares ]
]

{ #category : #'turn related' }
TrenchRunGame >> playNextTurn [

	| squaresForward ship |
	state update: self.
	ship := turnHandler nextSpaceshipTurn.
	squaresForward := cardHandler playedCardStack
		                  applyEffectsTo: ship
		                  using: dice roll.
	squaresForward := jail verifyMovabilityOf: ship whenRolling: squaresForward on: dice.
	self move: ship anAmountOf: squaresForward.
	self isFinished ifFalse: [ 
		history add: (gameBoard
				 applyEffectAt: (positionTracker squareOf: ship)
				 to: ship
				 on: self) ]
]

{ #category : #accessing }
TrenchRunGame >> positionTracker [

	^ positionTracker
]

{ #category : #accessing }
TrenchRunGame >> spaceships [ 

	^ positionTracker spaceships.
]

{ #category : #accessing }
TrenchRunGame >> turnHandler [

	^ turnHandler
]

{ #category : #'accessing - positions' }
TrenchRunGame >> winner [

	^ state winner: self
]
