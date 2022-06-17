Class {
	#name : #PlayedCardStackTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayedCardStackTest >> testAddingOneMovementEffectToEmptyStackReturnsOneOfEffectOnAllShips [

	| playedCardStack enterprise starfighter |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	playedCardStack := PlayedPermanentCardStack new.
	playedCardStack
		add: (AccelerationCard ownedBy: enterprise)
		aimingAt: { 
				starfighter.
				enterprise }.
	self
		assert: (playedCardStack applyEffectsTo: starfighter using: 1)
		equals: 2.
	self
		assert: (playedCardStack applyEffectsTo: enterprise using: 1)
		equals: 2
]

{ #category : #tests }
PlayedCardStackTest >> testAddingOneMovementEffectToExistingStackAugmentsTheEffectInOneOnAllShips [

	| playedCardStack enterprise starfighter |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	playedCardStack := PlayedPermanentCardStack new.
	playedCardStack
		add: (SpeedCard ownedBy: enterprise)
		aimingAt: { enterprise }.
	playedCardStack
		add: (AccelerationCard ownedBy: enterprise)
		aimingAt: { 
				enterprise.
				starfighter }.
	self
		assert: (playedCardStack applyEffectsTo: starfighter using: 1)
		equals: 2.
	self
		assert: (playedCardStack applyEffectsTo: enterprise using: 1)
		equals: 3
]

{ #category : #tests }
PlayedCardStackTest >> testCancellingAnEffectRemovesItFromTheCompoundEffectCalculation [

	| playedCardStack enterprise starfighter |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.
	playedCardStack := PlayedPermanentCardStack new.
	playedCardStack
		add: (SpeedCard ownedBy: enterprise)
		aimingAt: { starfighter }.
	self
		assert: (playedCardStack applyEffectsTo: starfighter using: 1)
		equals: 2.
	self
		assert: (playedCardStack applyEffectsTo: enterprise using: 1)
		equals: 1.
	playedCardStack remove: (PlayedPermanentCard
			 using: (SpeedCard ownedBy: enterprise)
			 aimingAt: { starfighter }).
	self
		assert: (playedCardStack applyEffectsTo: starfighter using: 1)
		equals: 1.
	self
		assert: (playedCardStack applyEffectsTo: enterprise using: 1)
		equals: 1
]
