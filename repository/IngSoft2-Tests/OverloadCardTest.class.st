Class {
	#name : #OverloadCardTest,
	#superclass : #CardTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
OverloadCardTest >> testOverloadCardEqualsAnotherOverloadCardWithSameValues [

	self
		assert: (OverloadCard ownedBy:  'Enterprise')
		equals: (OverloadCard ownedBy:  'Enterprise').
	self
		assert: (OverloadCard ownedBy: 'Enterprise') hash
		equals: (OverloadCard ownedBy: 'Enterprise') hash
]

{ #category : #tests }
OverloadCardTest >> testOverloadCardReducesInTwoTheNextPlayOfSelectedShip [

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
