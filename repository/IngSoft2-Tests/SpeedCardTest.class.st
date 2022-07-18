Class {
	#name : #SpeedCardTest,
	#superclass : #CardTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
SpeedCardTest >> testSpeedCardEqualsAnotherSpeedCardWithSameValues [

	self
		assert: (SpeedCard ownedBy: 'Enterprise')
		equals: (SpeedCard ownedBy: 'Enterprise').
	self
		assert: (SpeedCard ownedBy: 'Enterprise') hash
		equals: (SpeedCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
SpeedCardTest >> testSpeedCardIncreasesInOneThePlayOfSelectedShip [

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
