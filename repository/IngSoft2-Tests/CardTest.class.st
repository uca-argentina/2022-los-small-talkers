Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> testOverloadCardReducesInTwoTheNextPlayOfSelectedShip [

	| aGame enterprise board starfighter aDie squares overloadDeck|
	aDie := LoadedDie with: 5.
	squares := RandomObjectGenerator creating: 10 of: { BlankSquare } with: { 1 }.
	board := Board sized: 10 dividedIn: 10 from: squares.
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	overloadDeck := Deck handingOver: {OverloadCard}.
	aGame := TrenchRunGame
		         withParticipating: { 
				         enterprise.
				         starfighter }
		         rolling: aDie
		         on: board
		         until: 1
					using: overloadDeck.

	aGame playNextTurn.

	self assert: (aGame squareOf: enterprise) equals: 1.
	self assert: (aGame lapOf: enterprise) equals: 2.
	self assert: (aGame squareOf: starfighter) equals: 1.
	self assert: (aGame lapOf: starfighter) equals: 2
]
