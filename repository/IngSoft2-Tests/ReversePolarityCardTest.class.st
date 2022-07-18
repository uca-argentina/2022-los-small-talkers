Class {
	#name : #ReversePolarityCardTest,
	#superclass : #CardTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ReversePolarityCardTest >> testDoubleReversePolarityCardDoesNotReverseTheEffectOfAtomicBombSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: AtomicBombSquare new.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
		game
		playReversePolarityCardOwnedBy: planetExpress
		aimingAt: (squares at: 7).
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 1.
	self assert: (game squareOf: planetExpress) equals: 1.
	self assert: (game squareOf: starfighter) equals: 1
]

{ #category : #tests }
ReversePolarityCardTest >> testDoubleReversePolarityCardDoesNotReverseTheEffectOfDrawCardSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: DrawCardSquare new.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: planetExpress
		aimingAt: (squares at: 7).
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game amountOfCardsOf: enterprise) equals: 2.
	self assert: (game amountOfCardsOf: planetExpress) equals: 1.
	self assert: (game amountOfCardsOf: starfighter) equals: 2.
]

{ #category : #tests }
ReversePolarityCardTest >> testDoubleReversePolarityCardDoesNotReverseTheEffectOfHyperJumpSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: (HyperJumpSquare withParsecs: { 3 }).
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
		game
		playReversePolarityCardOwnedBy: planetExpress
		aimingAt: (squares at: 7).
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 53/5.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4
]

{ #category : #tests }
ReversePolarityCardTest >> testDoubleReversePolarityCardDoesNotReverseTheEffectOfMoonWalkSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: (MoonWalkSquare with: 1).
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
		game
		playReversePolarityCardOwnedBy: planetExpress
		aimingAt: (squares at: 7).
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 7.
	self assert: (game squareOf: planetExpress) equals: 3.
	self assert: (game squareOf: starfighter) equals: 3.
]

{ #category : #tests }
ReversePolarityCardTest >> testDoubleReversePolarityCardDoesNotReverseTheEffectOfSpeedUpSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: SpeedUpSquare new.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
		game
		playReversePolarityCardOwnedBy: planetExpress
		aimingAt: (squares at: 7).
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 11.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.
]

{ #category : #tests }
ReversePolarityCardTest >> testDoubleReversePolarityCardDoesNotReverseTheEffectOfSprintSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: SprintSquare new.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: planetExpress
		aimingAt: (squares at: 7).
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 8.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4
]

{ #category : #tests }
ReversePolarityCardTest >> testDoubleReversePolarityCardDoesNotReverseTheEffectOfWormHoleSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: WormHoleSquare new.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: planetExpress
		aimingAt: (squares at: 7).
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 3.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4
]

{ #category : #tests }
ReversePolarityCardTest >> testReversePolarityCardDoesNothingToBlankSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 4).
	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.
]

{ #category : #tests }
ReversePolarityCardTest >> testReversePolarityCardReversesTheEffectOfAtomicBombSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: AtomicBombSquare  new.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 7.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.
]

{ #category : #tests }
ReversePolarityCardTest >> testReversePolarityCardReversesTheEffectOfDrawCardSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: DrawCardSquare new.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game amountOfCardsOf: enterprise) equals: 1.
	self assert: (game amountOfCardsOf: planetExpress) equals: 3.
	self assert: (game amountOfCardsOf: starfighter) equals: 3.
]

{ #category : #tests }
ReversePolarityCardTest >> testReversePolarityCardReversesTheEffectOfHyperJumpSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: (HyperJumpSquare withParsecs: { 3 }).
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 7.
	self assert: (game squareOf: planetExpress) equals: 38/5.
	self assert: (game squareOf: starfighter) equals: 38/5
]

{ #category : #tests }
ReversePolarityCardTest >> testReversePolarityCardReversesTheEffectOfMoonWalkSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: (MoonWalkSquare with: 1).
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 6.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.
]

{ #category : #tests }
ReversePolarityCardTest >> testReversePolarityCardReversesTheEffectOfSpeedUpSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: SpeedUpSquare new.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
		game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 7.
	self assert: (game squareOf: planetExpress) equals: 8.
	self assert: (game squareOf: starfighter) equals: 8.
]

{ #category : #tests }
ReversePolarityCardTest >> testReversePolarityCardReversesTheEffectOfSprintSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: SprintSquare  new.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.

	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 7.
	self assert: (game squareOf: planetExpress) equals: 5.
	self assert: (game squareOf: starfighter) equals: 5.
]

{ #category : #tests }
ReversePolarityCardTest >> testReversePolarityCardReversesTheEffectOfWormHoleSquare [

	| game enterprise planetExpress starfighter aDie aBoard squares deck |
	enterprise := 'Enterprise'.
	planetExpress := 'PlanetExpress'.
	starfighter := 'StarFighter'.
	squares := SquareGenerator
		           creating: 12
		           of: { BlankSquare }
		           with: { 1 }.
	squares at: 7 put: WormHoleSquare new.
	deck := Deck handingOver: { ReversePolarityCard }.
	aBoard := Board madeUpBy: squares stretchedIntoParsecs: 10.
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

	game playNextTurn.
	game
		playReversePolarityCardOwnedBy: enterprise
		aimingAt: (squares at: 7).
	game playNextTurn.
	game playNextTurn.
	
		self assert: (game squareOf: enterprise) equals: 4.
	self assert: (game squareOf: planetExpress) equals: 4.
	self assert: (game squareOf: starfighter) equals: 4.
	
	game playNextTurn.

	self assert: (game squareOf: enterprise) equals: 7.
	self assert: (game squareOf: planetExpress) equals: 1.
	self assert: (game squareOf: starfighter) equals: 1
]
