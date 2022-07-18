Class {
	#name : #AccelerationCardTest,
	#superclass : #CardTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
AccelerationCardTest >> testAccelerationCardEqualsAnotherAccelerationCardWithSameValues [

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
AccelerationCardTest >> testAccelerationCardIncreasesInOneTheThrowOfAllShips [

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
