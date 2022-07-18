Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
CardTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^ self
		  should: aBlock
		  raise: anErrorType
		  whoseDescriptionIncludes: anErrorMessage
		  description: 'Test did not fail for expected reason'
]

{ #category : #accessing }
CardTest >> testAccelerationCardEqualsAnotherAccelerationCardWithSameValues [

	self
		assert: (AccelerationCard ownedBy: 'Enterprise')
		equals: (AccelerationCard ownedBy: 'Enterprise').
	self
		assert:
		(AccelerationCard ownedBy: 'Enterprise') hash
		equals:
		(AccelerationCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testAccelerationCardIncreasesInOneTheThrowOfAllShips [

	| game aDie aBoard squares deck |
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { AccelerationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating:
		        { 'Enterprise'. 'PlanetExpress'. 'StarFighter' }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game positionTracker squareOf: 'Enterprise') equals: 2.
	self
		assert: (game positionTracker squareOf: 'PlanetExpress')
		equals: 2.
	self assert: (game positionTracker squareOf: 'StarFighter') equals: 2.

	game cardPlayBy: 'StarFighter' using: AccelerationCard  aimingAt: {  }.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game positionTracker squareOf: 'Enterprise') equals: 4.
	self
		assert: (game positionTracker squareOf: 'PlanetExpress')
		equals: 4.
	self assert: (game positionTracker squareOf: 'StarFighter') equals: 4
]

{ #category : #tests }
CardTest >> testCancellationCardCannotBeUsedWhenNoPermanentCardsAreActive [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.

	self
		should: [ game cardPlayBy: enterprise using: CancellationCard aimingAt: (PlayedPermanentCard
						 using: (SpeedCard ownedBy: starfighter)
						 aimingAt: starfighter) . ]
		raise: Error
		withMessage: 'Cannot cancel a nonexistent effect'
]

{ #category : #accessing }
CardTest >> testCancellationCardEqualsAnotherCancellationCardWithSameValues [

	self
		assert: (CancellationCard ownedBy: 'Enterprise')
		equals: (CancellationCard ownedBy: 'Enterprise').
	self
		assert:
		(CancellationCard ownedBy: 'Enterprise') hash
		equals:
		(CancellationCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testCancellationCardRemovesAnActiveAccelerationCard [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: CancellationCard toHandsOf: starfighter.
	game give: AccelerationCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: AccelerationCard aimingAt: {  }.
	game
		cardPlayBy: starfighter
		using: CancellationCard
		aimingAt: (PlayedPermanentCard
				 using: (AccelerationCard ownedBy: enterprise)
				 aimingAt: { 
						 enterprise.
						 planetExpress.
						 starfighter }).

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game positionTracker squareOf: enterprise) equals: 3.
	self assert: (game positionTracker squareOf: planetExpress) equals: 2.
	self assert: (game positionTracker squareOf: starfighter) equals: 2
]

{ #category : #tests }
CardTest >> testDoubleCardAllowsSpaceshipToThrowTwice [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { DoubleCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 10).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.

	game playNextTurn.
	game cardPlayBy: enterprise using: DoubleCard.
	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 3.
	self assert: (game positionTracker squareOf: planetExpress) equals: 1.
	self assert: (game positionTracker squareOf: starfighter) equals: 1.
]

{ #category : #tests }
CardTest >> testDoubleCardEqualsAnotherDoubleCard [

	self
		assert: (DoubleCard ownedBy: 'Enterprise')
		equals: (DoubleCard ownedBy: 'Enterprise').
	self
		assert: (DoubleCard ownedBy: 'Enterprise') hash
		equals: (DoubleCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testFreedomCardEqualsAnotherFreedomCard [

	self
		assert: (FreedomCard ownedBy: 'Enterprise')
		equals: (FreedomCard ownedBy: 'Enterprise').
	self
		assert: (FreedomCard ownedBy: 'Enterprise') hash
		equals: (FreedomCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testFreedomCardFreesOwnerFromJail [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { JailSquare }
		           with: { 1 }.
	deck := Deck handingOver: { FreedomCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 10).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.

	game playNextTurn.
	self assert: (game jail isInJail: enterprise).

	game cardPlayBy: enterprise using: FreedomCard.
	self deny: (game jail isInJail: enterprise)
]

{ #category : #accessing }
CardTest >> testOverloadCardEqualsAnotherOverloadCardWithSameValues [

	self
		assert: (OverloadCard ownedBy:  'Enterprise')
		equals: (OverloadCard ownedBy:  'Enterprise').
	self
		assert: (OverloadCard ownedBy: 'Enterprise') hash
		equals: (OverloadCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testOverloadCardReducesInTwoTheNextPlayOfSelectedShip [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { OverloadCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game positionTracker squareOf: enterprise) equals: 2.
	self assert: (game positionTracker squareOf: planetExpress) equals: 2.
	self assert: (game positionTracker squareOf: starfighter) equals: 2.

	game
		cardPlayBy: starfighter
		using: OverloadCard
		aimingAt: { enterprise }.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game positionTracker squareOf: enterprise) equals: 1.
	self assert: (game positionTracker squareOf: planetExpress) equals: 3.
	self assert: (game positionTracker squareOf: starfighter) equals: 3
]

{ #category : #tests }
CardTest >> testPlayingAPermanentCardOutOfTurnIsInvalid [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: DrawCardSquare new.
	deck := Deck handingOver: { AccelerationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.

	game playNextTurn.

	self
		should: [ game cardPlayBy: planetExpress using: AccelerationCard aimingAt: {  }  ]
		raise: Error
		withMessage:
		'Cannot play permanent card when not in the spaceships turn'
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfACancellationCard [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: CancellationCard toHandsOf: starfighter.
	game give: RedoCard toHandsOf: starfighter.
	game give: AccelerationCard toHandsOf: enterprise.
	game give: SpeedCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: SpeedCard aimingAt: { enterprise }.
	game cardPlayBy: enterprise using: AccelerationCard aimingAt: {  }.

	game
		cardPlayBy: starfighter
		using: CancellationCard
		aimingAt: (PlayedPermanentCard
				 using: (AccelerationCard ownedBy: enterprise)
				 aimingAt: { 
						 enterprise.
						 starfighter.
						 planetExpress }).

	game
		cardPlayBy: starfighter
		using: RedoCard
		aimingAt: (PlayedPermanentCard
				 using: (SpeedCard ownedBy: enterprise)
				 aimingAt: { enterprise }).
	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game positionTracker squareOf: enterprise) equals: 3.
	self assert: (game positionTracker squareOf: planetExpress) equals: 2.
	self assert: (game positionTracker squareOf: starfighter) equals: 2
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfACancellationCardButAimedAtADifferentTarget [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: CancellationCard toHandsOf: starfighter.
	game give: RedoCard toHandsOf: starfighter.
	game give: AccelerationCard toHandsOf: enterprise.
	game give: SpeedCard toHandsOf: planetExpress.

	game playNextTurn.
	game cardPlayBy: enterprise using: AccelerationCard aimingAt: {  }.

	game playNextTurn.
	game
		cardPlayBy: planetExpress
		using: SpeedCard
		aimingAt: { planetExpress }.

	game playNextTurn.
	game cardPlayBy: starfighter using: CancellationCard aimingAt: (PlayedPermanentCard
				 using: (AccelerationCard ownedBy: enterprise)
				 aimingAt: { 
						 enterprise.
						 starfighter.
						 planetExpress }).
	game cardPlayBy: starfighter using: RedoCard aimingAt: (PlayedPermanentCard
			 using: (SpeedCard ownedBy: planetExpress)
			 aimingAt: { planetExpress }).
	game playNextTurn.
	game playNextTurn.
	self assert: (game positionTracker squareOf: enterprise) equals: 3.
	self assert: (game positionTracker squareOf: planetExpress) equals: 4.
	self assert: (game positionTracker squareOf: starfighter) equals: 3
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfARedoCard [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: CancellationCard toHandsOf: starfighter.
	game give: RedoCard toHandsOf: starfighter.
	game give: RedoCard toHandsOf: enterprise.
	game give: AccelerationCard toHandsOf: enterprise.
	game give: SpeedCard toHandsOf: planetExpress.
	game give: SpeedCard toHandsOf: starfighter.

	game playNextTurn.
	game cardPlayBy: enterprise using: AccelerationCard aimingAt: {  }.

	game playNextTurn.
	game
		cardPlayBy: planetExpress
		using: SpeedCard
		aimingAt: { planetExpress }.

	game playNextTurn.
	game
		cardPlayBy: starfighter
		using: SpeedCard
		aimingAt: { starfighter }.

	game
		cardPlayBy: starfighter
		using: CancellationCard
		aimingAt: (PlayedPermanentCard
				 using: (AccelerationCard ownedBy: enterprise)
				 aimingAt: { 
						 enterprise.
						 starfighter.
						 planetExpress }).
	game
		cardPlayBy: starfighter
		using: RedoCard
		aimingAt: (PlayedPermanentCard
				 using: (SpeedCard ownedBy: planetExpress)
				 aimingAt: { planetExpress }).

	game playNextTurn.
	game cardPlayBy: enterprise using: RedoCard aimingAt: (PlayedPermanentCard
			 using: (SpeedCard ownedBy: starfighter)
			 aimingAt: { starfighter }).

	game playNextTurn.
	self assert: (game positionTracker squareOf: enterprise) equals: 3.
	self assert: (game positionTracker squareOf: planetExpress) equals: 4.
	self assert: (game positionTracker squareOf: starfighter) equals: 3
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfARepeatCard [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 20
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: SpeedUpSquare new.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 20).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: CancellationCard toHandsOf: starfighter.
	game give: RepeatCard toHandsOf: starfighter.
	game give: RedoCard toHandsOf: enterprise.
	game give: AccelerationCard toHandsOf: enterprise.
	game give: SpeedCard toHandsOf: planetExpress.
	game give: SpeedCard toHandsOf: starfighter.

	game playNextTurn.
	game cardPlayBy: enterprise using: AccelerationCard aimingAt: {  }.

	game playNextTurn.
	game
		cardPlayBy: planetExpress
		using: SpeedCard
		aimingAt: { planetExpress }.

	game playNextTurn.
	game
		cardPlayBy: starfighter
		using: SpeedCard
		aimingAt: { starfighter }.

	game
		cardPlayBy: starfighter
		using: CancellationCard
		aimingAt: (PlayedPermanentCard
				 using: (AccelerationCard ownedBy: enterprise)
				 aimingAt: { 
						 enterprise.
						 starfighter.
						 planetExpress }).

	game cardPlayBy: starfighter using: RepeatCard aimingAt: starfighter.

	game playNextTurn.
	game cardPlayBy: enterprise using: RedoCard  aimingAt: enterprise.

	game playNextTurn.
	self assert: (game positionTracker squareOf: enterprise) equals: 7.
	self assert: (game positionTracker squareOf: planetExpress) equals: 5.
	self assert: (game positionTracker squareOf: starfighter) equals: 3
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfASpeedCard [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: RedoCard toHandsOf: planetExpress.
	game give: SpeedCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: SpeedCard aimingAt: { enterprise }.

	game playNextTurn.
	game cardPlayBy: planetExpress using: RedoCard aimingAt: { planetExpress }.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 4.
	self assert: (game positionTracker squareOf: planetExpress) equals: 4.
	self assert: (game positionTracker squareOf: starfighter) equals: 2
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfAnAccelerationCard [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: RedoCard toHandsOf: planetExpress.
	game give: AccelerationCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: AccelerationCard aimingAt: {  }.

	game playNextTurn.
	game cardPlayBy: planetExpress using: RedoCard aimingAt: { starfighter }.

	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 2.
	self assert: (game positionTracker squareOf: planetExpress) equals: 3.
	self assert: (game positionTracker squareOf: starfighter) equals: 4
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfAnOverloadCard [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: RedoCard toHandsOf: planetExpress.
	game give: OverloadCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: OverloadCard aimingAt: { planetExpress }.

	game playNextTurn.
	game cardPlayBy: planetExpress using: RedoCard aimingAt: { starfighter  }.

	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 2.
	self assert: (game positionTracker squareOf: planetExpress) equals: 1.
	self assert: (game positionTracker squareOf: starfighter) equals: 1
]

{ #category : #accessing }
CardTest >> testRedoCardEqualsAnotherRedoCardWithSameValues [

	self
		assert: (RedoCard ownedBy: 'Enterprise')
		equals: (RedoCard ownedBy: 'Enterprise').
	self
		assert: (RedoCard ownedBy: 'Enterprise') hash
		equals: (RedoCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfABlankSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: RepeatCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: RepeatCard aimingAt: { enterprise }.

	game playNextTurn.
	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 2.
	self assert: (game positionTracker squareOf: planetExpress) equals: 2.
	self assert: (game positionTracker squareOf: starfighter) equals: 2
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfADrawCardSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: DrawCardSquare new.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 5).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: RepeatCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: RepeatCard aimingAt: { enterprise }.

	game playNextTurn.
	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 2.
	self assert: (game positionTracker squareOf: planetExpress) equals: 2.
	self assert: (game positionTracker squareOf: starfighter) equals: 2
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfAHyperJumpSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: (HyperJumpSquare with: { Parsec amounting: 3 }).
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 10).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: RepeatCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: RepeatCard aimingAt: enterprise.

	game playNextTurn.
	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 8.
	self assert: (game positionTracker squareOf: planetExpress) equals: 5.
	self assert: (game positionTracker squareOf: starfighter) equals: 5
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfAMoonWalkSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: (MoonWalkSquare with: 1).
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 10).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: RepeatCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: RepeatCard aimingAt: enterprise.

	game playNextTurn.
	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 1.
	self assert: (game positionTracker squareOf: planetExpress) equals: 1.
	self assert: (game positionTracker squareOf: starfighter) equals: 2
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfASpeedUpSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 11
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: SpeedUpSquare new.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 11).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: RepeatCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: RepeatCard aimingAt: enterprise.

	game playNextTurn.
	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 10.
	self assert: (game positionTracker squareOf: planetExpress) equals: 6.
	self assert: (game positionTracker squareOf: starfighter) equals: 6
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfAWormHoleSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: WormHoleSquare new.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 10).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: RepeatCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: RepeatCard aimingAt: enterprise.

	game playNextTurn.
	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 1.
	self assert: (game positionTracker squareOf: planetExpress) equals: 1.
	self assert: (game positionTracker squareOf: starfighter) equals: 1
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfAnAtomicBombSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: AtomicBombSquare new.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 10).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: RepeatCard toHandsOf: enterprise.

	game playNextTurn.
	game cardPlayBy: enterprise using: RepeatCard aimingAt: enterprise.

	game playNextTurn.
	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 1.
	self assert: (game positionTracker squareOf: planetExpress) equals: 1.
	self assert: (game positionTracker squareOf: starfighter) equals: 1
]

{ #category : #accessing }
CardTest >> testRepeatCardEqualsAnotherRepeatCardWithSameValues [

	self
		assert: (RepeatCard ownedBy: 'Enterprise')
		equals: (RepeatCard ownedBy: 'Enterprise').
	self
		assert: (RepeatCard ownedBy: 'Enterprise') hash
		equals: (RepeatCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testReverseCardEqualsAnotherReverseCard [

	self
		assert: (ReverseCard ownedBy: 'Enterprise')
		equals: (ReverseCard  ownedBy: 'Enterprise').
	self
		assert: (ReverseCard ownedBy: 'Enterprise') hash
		equals: (ReverseCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testReverseCardReversesTheOrderOfTurns [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { ReverseCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 10).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
		
	game playNextTurn.
	game cardPlayBy: starfighter using: ReverseCard.
	game playNextTurn.

	self
		assert: game turnHandler currentSpaceshipTurn
		equals: starfighter
]

{ #category : #accessing }
CardTest >> testSkipCardEqualsAnotherSkipCardWithSameValues [

	self
		assert: (SkipCard ownedBy: 'Enterprise')
		equals: (SkipCard ownedBy: 'Enterprise').
	self
		assert: (SkipCard ownedBy: 'Enterprise') hash
		equals: (SkipCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testSkipCardSkipsToTheNextTurn [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { SkipCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 10).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
	game give: AccelerationCard toHandsOf: enterprise.
	game playNextTurn.
	game cardPlayBy: starfighter using: SkipCard.
	
	self assert: (game turnHandler currentSpaceshipTurn) equals: planetExpress
]

{ #category : #accessing }
CardTest >> testSpeedCardEqualsAnotherSpeedCardWithSameValues [

	self
		assert: (SpeedCard ownedBy: 'Enterprise')
		equals: (SpeedCard ownedBy: 'Enterprise').
	self
		assert: (SpeedCard ownedBy: 'Enterprise') hash
		equals: (SpeedCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testSpeedCardIncreasesInOneThePlayOfSelectedShip [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { SpeedCard }.
	aBoard := Board
		          madeUpBy: squares
		          stretchedInto: (Parsec amounting: 10).
	aDie := LoadedDie with: 1.
	game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.

	game playNextTurn.
	game cardPlayBy: enterprise using: SpeedCard aimingAt: { enterprise }.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.

	self assert: (game positionTracker squareOf: enterprise) equals: 4.
	self assert: (game positionTracker squareOf: planetExpress) equals: 2.
	self assert: (game positionTracker squareOf: starfighter) equals: 2
]
