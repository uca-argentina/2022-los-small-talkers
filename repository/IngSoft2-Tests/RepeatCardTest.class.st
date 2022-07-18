Class {
	#name : #RepeatCardTest,
	#superclass : #CardTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RepeatCardTest >> testRepeatCardAppliesTheEffectOfABlankSquare [

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
RepeatCardTest >> testRepeatCardAppliesTheEffectOfADrawCardSquare [

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
RepeatCardTest >> testRepeatCardAppliesTheEffectOfAHyperJumpSquare [

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
RepeatCardTest >> testRepeatCardAppliesTheEffectOfAMoonWalkSquare [

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
RepeatCardTest >> testRepeatCardAppliesTheEffectOfASpeedUpSquare [

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
RepeatCardTest >> testRepeatCardAppliesTheEffectOfAWormHoleSquare [

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
RepeatCardTest >> testRepeatCardAppliesTheEffectOfAnAtomicBombSquare [

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
RepeatCardTest >> testRepeatCardEqualsAnotherRepeatCardWithSameValues [

	self
		assert: (RepeatCard ownedBy: 'Enterprise')
		equals: (RepeatCard ownedBy: 'Enterprise').
	self
		assert: (RepeatCard ownedBy: 'Enterprise') hash
		equals: (RepeatCard ownedBy: 'Enterprise') hash
]
