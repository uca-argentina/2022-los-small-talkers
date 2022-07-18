Class {
	#name : #RedoCardTest,
	#superclass : #CardTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RedoCardTest >> testRedoCardAppliesTheEffectOfACancellationCard [

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
RedoCardTest >> testRedoCardAppliesTheEffectOfACancellationCardButAimedAtADifferentTarget [

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
RedoCardTest >> testRedoCardAppliesTheEffectOfARedoCard [

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
RedoCardTest >> testRedoCardAppliesTheEffectOfARepeatCard [

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
RedoCardTest >> testRedoCardAppliesTheEffectOfASpeedCard [

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
RedoCardTest >> testRedoCardAppliesTheEffectOfAnAccelerationCard [

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
RedoCardTest >> testRedoCardAppliesTheEffectOfAnOverloadCard [

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
RedoCardTest >> testRedoCardEqualsAnotherRedoCardWithSameValues [

	self
		assert: (RedoCard ownedBy: 'Enterprise')
		equals: (RedoCard ownedBy: 'Enterprise').
	self
		assert: (RedoCard ownedBy: 'Enterprise') hash
		equals: (RedoCard ownedBy: 'Enterprise') hash
]
