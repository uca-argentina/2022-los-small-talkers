Class {
	#name : #CacellationCardTest,
	#superclass : #CardTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CacellationCardTest >> testCancellationCardCannotBeUsedWhenNoPermanentCardsAreActive [

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
CacellationCardTest >> testCancellationCardEqualsAnotherCancellationCardWithSameValues [

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
CacellationCardTest >> testCancellationCardRemovesAnActiveAccelerationCard [

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
	self assert: (game squareOf: starfighter) equals: 2
]
