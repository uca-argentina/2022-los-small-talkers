Class {
	#name : #PlayedCard,
	#superclass : #Object,
	#instVars : [
		'card',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
PlayedCard class >> using: aCard aimingAt: target [

	^ self new initializeUsing: aCard aimingAt: target.
]

{ #category : #'applying effects' }
PlayedCard >> applyEffectsTo: spaceship using: anInitialValue [

	(target includes: spaceship) ifTrue: [ 
		^(card applyEffectsUsing: anInitialValue) ].
	^anInitialValue.
]

{ #category : #accessing }
PlayedCard >> card [

	^ card
]

{ #category : #initialization }
PlayedCard >> initializeUsing: aCard aimingAt: aTarget [

	card := aCard.
	target := aTarget.
]

{ #category : #accessing }
PlayedCard >> target [

	^ target
]
