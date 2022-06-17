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
		assert: (AccelerationCard ownedBy: (Spaceship named: 'Enterprise'))
		equals: (AccelerationCard  ownedBy: (Spaceship named: 'Enterprise')).
	self
		assert: (AccelerationCard  ownedBy: (Spaceship named: 'Enterprise')) hash
		equals: (AccelerationCard  ownedBy: (Spaceship named: 'Enterprise')) hash
]

{ #category : #tests }
CardTest >> testAccelerationCardIncreasesInOneTheThrowOfAllShips [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { AccelerationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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

	game playAccelerationCardOwnedBy: starfighter.

	game playNextTurn.
	game playNextTurn.
	game playNextTurn.
	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4
]

{ #category : #tests }
CardTest >> testCancellationCardCannotBeUsedWhenNoPermanentCardsAreActive [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
		assert: (CancellationCard ownedBy: (Spaceship named: 'Enterprise'))
		equals: (CancellationCard  ownedBy: (Spaceship named: 'Enterprise')).
	self
		assert: (CancellationCard  ownedBy: (Spaceship named: 'Enterprise')) hash
		equals: (CancellationCard  ownedBy: (Spaceship named: 'Enterprise')) hash
]

{ #category : #tests }
CardTest >> testCancellationCardRemovesAnActiveAccelerationCard [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
	self assert: (game squareOf: starfighter) equals: 2
]

{ #category : #accessing }
CardTest >> testOverloadCardEqualsAnotherOverloadCardWithSameValues [

	self
		assert: (OverloadCard  ownedBy: (Spaceship named: 'Enterprise'))
		equals: (OverloadCard  ownedBy: (Spaceship named: 'Enterprise')).
	self
		assert:
		(OverloadCard  ownedBy: (Spaceship named: 'Enterprise')) hash
		equals:
		(OverloadCard  ownedBy: (Spaceship named: 'Enterprise')) hash
]

{ #category : #tests }
CardTest >> testOverloadCardReducesInTwoTheNextPlayOfSelectedShip [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { OverloadCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: DrawCardSquare new.
	deck := Deck handingOver: { AccelerationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
		withMessage: 	'Cannot play permanent card when not in the spaceships turn'
]

{ #category : #tests }
CardTest >> testRedoCardAppliesTheEffectOfACancellationCard [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
	game
		playSpeedCardOwnedBy: planetExpress
		aimingAt: { planetExpress }.

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
	game
		playRedoCardOwnedBy: starfighter
		aimingAt: (PlayedPermanentCard
				 using: (SpeedCard ownedBy: planetExpress)
				 aimingAt: { planetExpress }).

	game playNextTurn.
	game
		playRedoCardOwnedBy: enterprise
		aimingAt: (PlayedPermanentCard
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
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 20
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: SpeedUpSquare new.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 20 dividedInParsecs: 20 from: squares.
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
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
	game
		playRedoCardOwnedBy: planetExpress
		aimingAt: { planetExpress }.

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
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
	game playAccelerationCardOwnedBy: enterprise .

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
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
	game
		playOverloadCardOwnedBy: enterprise
		aimingAt: { planetExpress }.

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
		assert: (RedoCard ownedBy: (Spaceship named: 'Enterprise'))
		equals: (RedoCard ownedBy: (Spaceship named: 'Enterprise')).
	self
		assert:
		(RedoCard ownedBy: (Spaceship named: 'Enterprise')) hash
		equals:
		(RedoCard ownedBy: (Spaceship named: 'Enterprise')) hash
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfABlankSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 5
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: DrawCardSquare new.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 5 dividedInParsecs: 5 from: squares.
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
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: (HyperJumpSquare withParsecs: { 3 }).
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 10 dividedInParsecs: 10 from: squares.
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
	game playRepeatCardOwnedBy: enterprise aimingAt: enterprise .

	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 8.
	self assert: (game squareOf: planetExpress) equals: 5.
	self assert: (game squareOf: starfighter) equals: 5
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfAMoonWalkSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: (MoonWalkSquare with: 1).
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 10 dividedInParsecs: 10 from: squares.
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
	game playRepeatCardOwnedBy: enterprise aimingAt: enterprise .

	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 1.
	self assert: (game squareOf: planetExpress) equals: 1.
	self assert: (game squareOf: starfighter) equals: 2
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfASpeedUpSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 11
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: SpeedUpSquare new.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 11 dividedInParsecs: 11 from: squares.
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
	game playRepeatCardOwnedBy: enterprise aimingAt: enterprise .

	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 10.
	self assert: (game squareOf: planetExpress) equals: 6.
	self assert: (game squareOf: starfighter) equals: 6
]

{ #category : #tests }
CardTest >> testRepeatCardAppliesTheEffectOfAWormHoleSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: WormHoleSquare new.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 10 dividedInParsecs: 10 from: squares.
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
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 2 put: AtomicBombSquare new.
	deck := Deck handingOver: { CancellationCard }.
	aBoard := Board sized: 10 dividedInParsecs: 10 from: squares.
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
		assert: (RepeatCard ownedBy: (Spaceship named: 'Enterprise'))
		equals: (RepeatCard ownedBy: (Spaceship named: 'Enterprise')).
	self
		assert: (RepeatCard ownedBy: (Spaceship named: 'Enterprise')) hash
		equals: (RepeatCard ownedBy: (Spaceship named: 'Enterprise')) hash
]

{ #category : #accessing }
CardTest >> testSpeedCardEqualsAnotherSpeedCardWithSameValues [

	self assert: (SpeedCard ownedBy: (Spaceship named: 'Enterprise')) equals: (SpeedCard ownedBy: (Spaceship named: 'Enterprise')).
	self assert: (SpeedCard ownedBy: (Spaceship named: 'Enterprise')) hash equals: (SpeedCard ownedBy: (Spaceship named: 'Enterprise')) hash.
]

{ #category : #tests }
CardTest >> testSpeedCardIncreasesInOneThePlayOfSelectedShip [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'PlanetExpress'.
	starfighter := Spaceship named: 'StarFighter'.
	squares := SquareGenerator
		           creating: 10
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { SpeedCard }.
	aBoard := Board sized: 10 dividedInParsecs: 10 from: squares.
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
