Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> testAccelerationCardIncreasesInOneTheThrowOfAllShips [

	self shouldBeImplemented 
]

{ #category : #tests }
CardTest >> testCancellationCardCannotBeUsedWhenNoPermanentCardsAreActive [

	self shouldBeImplemented 
]

{ #category : #tests }
CardTest >> testCancellationCardRemovesAnActiveAccelerationCard [

	self shouldBeImplemented 
]

{ #category : #tests }
CardTest >> testOverloadCardReducesInTwoTheNextPlayOfSelectedShip [

	| aGame enterprise board starfighter aDie squares overloadDeck |
	aDie := LoadedDie with: 5.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	board := Board sized: 10 dividedIn: 10 from: squares.
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	overloadDeck := Deck handingOver: { OverloadCard }.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter }
		         rolling: aDie
		         on: board
		         until: 1
		         using: overloadDeck.

	aGame playOverloadCardOf: enterprise targetting: starfighter.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 6.
	self assert: (aGame lapOf: enterprise) equals: 1.
	self assert: (aGame squareOf: starfighter) equals: 4.
	self assert: (aGame lapOf: starfighter) equals: 1.
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfACancellationCard [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfACancellationCardButAimedAtADifferentTarget [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfARedoCard [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfARepeatCard [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfASpeedCard [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfAnAccelerationCard [

	self shouldBeImplemented 
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfAnOverloadCard [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfABlankSquare [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfADrawCardSquare [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfAHyperJumpSquare [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfAMoonWalkSquare [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfASpeedUpSquare [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfAWormHoleSquare [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfAnAtomicBombSquare [

	self shouldBeImplemented
]

{ #category : #tests }
CardTest >> testSpeedCardIncreasesInOneThePlayOfSelectedShip [

	self shouldBeImplemented
]
