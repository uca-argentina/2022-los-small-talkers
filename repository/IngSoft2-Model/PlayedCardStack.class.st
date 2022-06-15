Class {
	#name : #PlayedCardStack,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
PlayedCardStack >> add: aCard aimingAt: target [

	stack add: (PlayedCard using: aCard aimingAt: target)
]

{ #category : #'calculating composed effects' }
PlayedCardStack >> applyEffectsTo: spaceship using: anInitialValue [

	| resultingEffect |
	resultingEffect := anInitialValue.
	stack do: [ :playedCard | 
		resultingEffect := playedCard
			                   applyEffectsTo: spaceship
			                   using: anInitialValue ].
	^ resultingEffect
]

{ #category : #initialization }
PlayedCardStack >> initialize [
	
	super initialize.
	stack := OrderedCollection new.
]

{ #category : #accessing }
PlayedCardStack >> remove: cardType playedBy: spaceship aimingAt: target [

	stack remove: (PlayedCard using: (cardType ownedBy: spaceship) aimingAt: target) ifAbsent: [ Error signal: 'Cannot remove a nonexistent effect' ].
]
