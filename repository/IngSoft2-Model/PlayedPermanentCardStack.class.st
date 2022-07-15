Class {
	#name : #PlayedPermanentCardStack,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
PlayedPermanentCardStack >> add: aCard aimingAt: target [

	stack add: (PlayedPermanentCard using: aCard aimingAt: target)
]

{ #category : #'calculating composed effects' }
PlayedPermanentCardStack >> applyEffectsTo: spaceship using: anInitialValue [

	| resultingEffect |
	resultingEffect := anInitialValue.
	stack do: [ :playedCard | 
		resultingEffect := playedCard
			                   applyEffectsTo: spaceship
			                   using: resultingEffect ].
	^ resultingEffect
]

{ #category : #accessing }
PlayedPermanentCardStack >> cancel: aPlayedPermanentCard [

	stack
		remove: aPlayedPermanentCard
		ifAbsent: [ Error signal: 'Cannot cancel a nonexistent effect' ]
]

{ #category : #initialization }
PlayedPermanentCardStack >> initialize [
	
	super initialize.
	stack := OrderedCollection new.
]

{ #category : #accessing }
PlayedPermanentCardStack >> remove: aPlayedPermanentCard [

	stack
		remove: aPlayedPermanentCard
		ifAbsent: [ Error signal: 'Cannot remove a nonexistent effect' ]
]
