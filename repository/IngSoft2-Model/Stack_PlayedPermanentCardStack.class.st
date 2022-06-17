Class {
	#name : #'Stack_PlayedPermanentCardStack',
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Stack_PlayedPermanentCardStack >> add: aCard aimingAt: target [

	stack add: (PlayedPermanentCard using: aCard aimingAt: target)
]

{ #category : #'calculating composed effects' }
Stack_PlayedPermanentCardStack >> applyEffectsTo: spaceship using: anInitialValue [

	| resultingEffect |
	resultingEffect := anInitialValue.
	stack do: [ :playedCard | 
		resultingEffect := playedCard
			                   applyEffectsTo: spaceship
			                   using: resultingEffect ].
	^ resultingEffect
]

{ #category : #initialization }
Stack_PlayedPermanentCardStack >> initialize [
	
	super initialize.
	stack := OrderedCollection new.
]

{ #category : #accessing }
Stack_PlayedPermanentCardStack >> remove: aPlayedPermanentCard [

	stack
		remove: aPlayedPermanentCard
		ifAbsent: [ Error signal: 'Cannot remove a nonexistent effect' ]
]
