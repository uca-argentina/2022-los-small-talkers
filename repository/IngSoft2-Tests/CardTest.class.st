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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	self assert: (game squareOf: 'Enterprise') equals: 2.
	self assert: (game squareOf: 'PlanetExpress') equals: 2.
	self assert: (game squareOf: 'StarFighter') equals: 2.

	game playAccelerationCardOwnedBy: 'StarFighter'.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game squareOf: 'Enterprise') equals: 4.
	self assert: (game squareOf: 'PlanetExpress') equals: 4.
	self assert: (game squareOf: 'StarFighter') equals: 4
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
		should: [ 
			game
				playCancellationCardOwnedBy: enterprise
				aimingAt: (PlayedPermanentCard
						 using: (SpeedCard ownedBy: starfighter)
						 aimingAt: starfighter) ]
		raise: Error
		withMessage: 'Cannot remove a nonexistent effect'
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	game playAccelerationCardOwnedBy: enterprise.
	game
		playCancellationCardOwnedBy: starfighter
		aimingAt: (PlayedPermanentCard
				 using: (AccelerationCard ownedBy: enterprise)
				 aimingAt: { 
						 enterprise.
						 planetExpress.
						 starfighter }).
	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game squareOf: enterprise) equals: 3.
	self assert: (game squareOf: planetExpress) equals: 2.
	self assert: (game squareOf: starfighter) equals: 2.
	self
		should: [ 
			game
				playCancellationCardOwnedBy: starfighter
				aimingAt: (PlayedPermanentCard
						 using: (AccelerationCard ownedBy: enterprise)
						 aimingAt: { 
						 			enterprise.
						 			planetExpress.
						 			starfighter }) ]
		raise: Error
		withMessage: 'Cannot remove a nonexistent effect'
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	self assert: (game squareOf: enterprise) equals: 2.
	self assert: (game squareOf: planetExpress) equals: 2.
	self assert: (game squareOf: starfighter) equals: 2.

	game playOverloadCardOwnedBy: starfighter aimingAt: { enterprise }.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game squareOf: enterprise) equals: 1.
	self assert: (game squareOf: planetExpress) equals: 3.
	self assert: (game squareOf: starfighter) equals: 3
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
		should: [ game playAccelerationCardOwnedBy: planetExpress ]
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	game playSpeedCardOwnedBy: enterprise aimingAt: { enterprise }.
	game playAccelerationCardOwnedBy: enterprise.

	game
		playCancellationCardOwnedBy: starfighter
		aimingAt: (PlayedPermanentCard
				 using: (AccelerationCard ownedBy: enterprise)
				 aimingAt: { 
						 enterprise.
						 starfighter.
						 planetExpress }).

	game playRedoCardOwnedBy: starfighter aimingAt: (PlayedPermanentCard
			 using: (SpeedCard ownedBy: enterprise)
			 aimingAt: { enterprise }).
	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game squareOf: enterprise) equals: 3.
	self assert: (game squareOf: planetExpress) equals: 2.
	self assert: (game squareOf: starfighter) equals: 2
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	game playAccelerationCardOwnedBy: enterprise.

	game playNextTurn.
	game playSpeedCardOwnedBy: planetExpress aimingAt: { planetExpress }.

	game playNextTurn.
	game
		playCancellationCardOwnedBy: starfighter
		aimingAt: (PlayedPermanentCard
				 using: (AccelerationCard ownedBy: enterprise)
				 aimingAt: { 
						 enterprise.
						 starfighter.
						 planetExpress }).
	game playRedoCardOwnedBy: starfighter aimingAt: (PlayedPermanentCard
			 using: (SpeedCard ownedBy: planetExpress)
			 aimingAt: { planetExpress }).
	game playNextTurn.
	game playNextTurn.
	self assert: (game squareOf: enterprise) equals: 3.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 3
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	game playAccelerationCardOwnedBy: enterprise.

	game playNextTurn.
	game playSpeedCardOwnedBy: planetExpress aimingAt: { planetExpress }.

	game playNextTurn.
	game playSpeedCardOwnedBy: starfighter aimingAt: { starfighter }.

	game
		playCancellationCardOwnedBy: starfighter
		aimingAt: (PlayedPermanentCard
				 using: (AccelerationCard ownedBy: enterprise)
				 aimingAt: { 
						 enterprise.
						 starfighter.
						 planetExpress }).
	game playRedoCardOwnedBy: starfighter aimingAt: (PlayedPermanentCard
			 using: (SpeedCard ownedBy: planetExpress)
			 aimingAt: { planetExpress }).

	game playNextTurn.
	game playRedoCardOwnedBy: enterprise aimingAt: (PlayedPermanentCard
			 using: (SpeedCard ownedBy: starfighter)
			 aimingAt: { starfighter }).

	game playNextTurn.
	self assert: (game squareOf: enterprise) equals: 3.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 3
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 20.
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
	game playAccelerationCardOwnedBy: enterprise.

	game playNextTurn.
	game playSpeedCardOwnedBy: planetExpress aimingAt: { planetExpress }.

	game playNextTurn.
	game playSpeedCardOwnedBy: starfighter aimingAt: { starfighter }.

	game
		playCancellationCardOwnedBy: starfighter
		aimingAt: (PlayedPermanentCard
				 using: (AccelerationCard ownedBy: enterprise)
				 aimingAt: { 
						 enterprise.
						 starfighter.
						 planetExpress }).
	game playRepeatCardOwnedBy: starfighter aimingAt: starfighter.

	game playNextTurn.
	game playRedoCardOwnedBy: enterprise aimingAt: enterprise.

	game playNextTurn.
	self assert: (game squareOf: enterprise) equals: 7.
	self assert: (game squareOf: planetExpress) equals: 5.
	self assert: (game squareOf: starfighter) equals: 3
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	game playSpeedCardOwnedBy: enterprise aimingAt: { enterprise }.

	game playNextTurn.
	game playRedoCardOwnedBy: planetExpress aimingAt: { planetExpress }.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 2
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	game playAccelerationCardOwnedBy: enterprise.

	game playNextTurn.
	game playRedoCardOwnedBy: planetExpress aimingAt: { starfighter }.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 2.
	self assert: (game squareOf: planetExpress) equals: 3.
	self assert: (game squareOf: starfighter) equals: 4
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	game playOverloadCardOwnedBy: enterprise aimingAt: { planetExpress }.

	game playNextTurn.
	game playRedoCardOwnedBy: planetExpress aimingAt: { starfighter }.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 2.
	self assert: (game squareOf: planetExpress) equals: 1.
	self assert: (game squareOf: starfighter) equals: 1
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	game playRepeatCardOwnedBy: enterprise aimingAt: { enterprise }.

	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 2.
	self assert: (game squareOf: planetExpress) equals: 2.
	self assert: (game squareOf: starfighter) equals: 2
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 5.
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
	game playRepeatCardOwnedBy: enterprise aimingAt: { enterprise }.

	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 2.
	self assert: (game squareOf: planetExpress) equals: 2.
	self assert: (game squareOf: starfighter) equals: 2
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
	squares at: 2 put: (HyperJumpSquare withParsecs: { 3 }).
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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
	game playRepeatCardOwnedBy: enterprise aimingAt: enterprise.

	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 8.
	self assert: (game squareOf: planetExpress) equals: 5.
	self assert: (game squareOf: starfighter) equals: 5
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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
	game playRepeatCardOwnedBy: enterprise aimingAt: enterprise.

	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 1.
	self assert: (game squareOf: planetExpress) equals: 1.
	self assert: (game squareOf: starfighter) equals: 2
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 11.
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
	game playRepeatCardOwnedBy: enterprise aimingAt: enterprise.

	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 10.
	self assert: (game squareOf: planetExpress) equals: 6.
	self assert: (game squareOf: starfighter) equals: 6
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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
	game playRepeatCardOwnedBy: enterprise aimingAt: enterprise.

	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 1.
	self assert: (game squareOf: planetExpress) equals: 1.
	self assert: (game squareOf: starfighter) equals: 1
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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
	game playRepeatCardOwnedBy: enterprise aimingAt: { enterprise }.

	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 1.
	self assert: (game squareOf: planetExpress) equals: 1.
	self assert: (game squareOf: starfighter) equals: 1
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
CardTest >> testReversalCardCantBePlayedIfNotOwnedByTheSpaceship [

	| aGame enterprise dice board squares star |
	dice := LoadedDie with: 7.
	squares := SquareGenerator
		           creating: 30
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 8 put: SpeedUpSquare new.
	board := Board madeUpBy: squares stretchedIntoParsecs: 30.
	enterprise := 'Enterprise'.
	star := 'Star'.
	aGame := TrenchRunGame
		         withParticipating: { enterprise. star }
		         rolling: dice
		         on: board
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).
	
	aGame give: ReversalCard toHandsOf: star.
	aGame playNextTurn.
	
	
	self
		should: [ aGame playReversalCardOwnedBy: enterprise aimingAt: star. ]
		raise: Error
		withMessage: 'Player does not own the selected card'.
	
	
]

{ #category : #accessing }
CardTest >> testReversalCardEqualsAnotherReversalCardWithSameValues [

	self
		assert: (ReversalCard  ownedBy: 'Enterprise')
		equals: (ReversalCard  ownedBy: 'Enterprise').
	self
		assert:
		(ReversalCard  ownedBy: 'Enterprise') hash
		equals:
		(ReversalCard  ownedBy: 'Enterprise') hash
]

{ #category : #tests }
CardTest >> testReversalCardHasNoEffectWhenOwnerUsesItOnABlankSquare [
	| game enterprise planetExpress starfighter aDie aBoard squares deck |
		enterprise := 'Enterprise'.
		planetExpress := 'PlanetExpress'.
		starfighter := 'StarFighter'.
		squares := SquareGenerator
			           creating: 20
		 	          of: { BlankSquare }
		  	         with: { 1 }.
		deck := Deck handingOver: { SpeedCard }.
		aBoard := Board madeUpBy: squares stretchedIntoParsecs: 20.
		aDie := LoadedDie with: 3.
		game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
		
		game give: ReversalCard toHandsOf: enterprise.
		game playNextTurn.
		game playNextTurn.
		game playNextTurn.
		game playNextTurn.
		game playReversalCardOwnedBy: enterprise aimingAt: starfighter.
		game playNextTurn.

		self assert: (game squareOf: enterprise) equals: 7.
		self assert: (game squareOf: planetExpress) equals: 7.
		self assert: (game squareOf: starfighter) equals: 4.
]

{ #category : #tests }
CardTest >> testReversalCardHasSameEffectAsOriginalSquareWhenOwnerShipLandsOnAtomicBombSquare [
	| game enterprise planetExpress starfighter aDie aBoard squares deck |
		enterprise := 'Enterprise'.
		planetExpress := 'PlanetExpress'.
		starfighter := 'StarFighter'.
		squares := SquareGenerator
			           creating: 20
		 	          of: { BlankSquare }
		  	         with: { 1 }.
		deck := Deck handingOver: { SpeedCard }.
		aBoard := Board madeUpBy: squares stretchedIntoParsecs: 20.
		aDie := LoadedDie with: 3.
		game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
		squares at: 7 put: AtomicBombSquare new.
		game give: ReversalCard toHandsOf: enterprise.
		game playNextTurn.
		game playNextTurn.
		game playNextTurn.
		game playNextTurn.
		game playReversalCardOwnedBy: enterprise aimingAt: starfighter.
		game playNextTurn.

		self assert: (game squareOf: enterprise) equals: 1.
		self assert: (game squareOf: planetExpress) equals: 4.
		self assert: (game squareOf: starfighter) equals: 1.
]

{ #category : #tests }
CardTest >> testReversalCardHasSameEffectAsOriginalSquareWhenOwnerShipLandsOnDrawCardSquare [
	| aGame enterprise dice board squares star |
	dice := LoadedDie with: 7.
	squares := SquareGenerator
		           creating: 30
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 8 put: DrawCardSquare new.
	board := Board madeUpBy: squares stretchedIntoParsecs: 30.
	enterprise := 'Enterprise'.
	star := 'Star'.
	aGame := TrenchRunGame
		         withParticipating: { enterprise. star }
		         rolling: dice
		         on: board
		         until: 1
		         using: (Deck handingOver: { SpeedCard }).
	
	aGame give: ReversalCard toHandsOf: star.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playReversalCardOwnedBy: star aimingAt: star.
	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 15.
	self assert: (aGame squareOf: star) equals: 8.
]

{ #category : #tests }
CardTest >> testReversalCardMovesTargetSpaceshipBackwardsAnAmountOfFourWhenOwnerShipLandsOnSpeedUpSquare [
	| game enterprise planetExpress starfighter aDie aBoard squares deck |
		enterprise := 'Enterprise'.
		planetExpress := 'PlanetExpress'.
		starfighter := 'StarFighter'.
		squares := SquareGenerator
			           creating: 20
		 	          of: { BlankSquare }
		  	         with: { 1 }.
		deck := Deck handingOver: { SpeedCard }.
		aBoard := Board madeUpBy: squares stretchedIntoParsecs: 20.
		aDie := LoadedDie with: 3.
		game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
		squares at: 7 put: SpeedUpSquare new.
		game give: ReversalCard toHandsOf: enterprise.
		game playNextTurn.
		game playNextTurn.
		game playNextTurn.
		game playNextTurn.
		game playReversalCardOwnedBy: enterprise aimingAt: starfighter.
		game playNextTurn.

		self assert: (game squareOf: enterprise) equals: 11.
		self assert: (game squareOf: planetExpress) equals: 3.
		self assert: (game squareOf: starfighter) equals: 4.
]

{ #category : #tests }
CardTest >> testReversalCardMovesTargetSpaceshipBackwardsAnAmountOfLightYearsWhenOwnerLandsOnHyperJumpSquare [

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
	game give: ReversalCard toHandsOf: enterprise.
	game playNextTurn.
	game playReversalCardOwnedBy: enterprise aimingAt: enterprise.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
]

{ #category : #tests }
CardTest >> testReversalCardMovesTargetSpaceshipForwardAnAmountOfFourSquaresWhenOwnerLandsOnWormHoleSquare [
	| game enterprise planetExpress starfighter aDie aBoard squares deck |
		enterprise := 'Enterprise'.
		planetExpress := 'PlanetExpress'.
		starfighter := 'StarFighter'.
		squares := SquareGenerator
			           creating: 20
		 	          of: { BlankSquare }
		  	         with: { 1 }.
		deck := Deck handingOver: { SpeedCard }.
		aBoard := Board madeUpBy: squares stretchedIntoParsecs: 20.
		aDie := LoadedDie with: 3.
		game := TrenchRunGame
		        withParticipating: { 
				        enterprise.
				        planetExpress.
				        starfighter }
		        rolling: aDie
		        on: aBoard
		        until: 1
		        using: deck.
		squares at: 7 put: WormHoleSquare new.
		game give: ReversalCard toHandsOf: enterprise.
		game playNextTurn.
		game playNextTurn.
		game playNextTurn.
		game playNextTurn.
		game playReversalCardOwnedBy: enterprise aimingAt: planetExpress.
		game playNextTurn.

		self assert: (game squareOf: enterprise) equals: 3.
		self assert: (game squareOf: planetExpress) equals: 11.
		self assert: (game squareOf: starfighter) equals: 4.
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
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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
	game playSpeedCardOwnedBy: enterprise aimingAt: { enterprise }.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 2.
	self assert: (game squareOf: starfighter) equals: 2
]
