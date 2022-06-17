Class {
	#name : #PlayedPermanentCard,
	#superclass : #Object,
	#instVars : [
		'card',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
PlayedPermanentCard class >> using: aCard aimingAt: target [

	^ self new initializeUsing: aCard aimingAt: target.
]

{ #category : #comparing }
PlayedPermanentCard >> = anotherPlayedPermanentCard [

	| targetMatches |
	targetMatches := false.
	target isCollection
		ifTrue: [ 
			targetMatches := (target includesAll:
				                  anotherPlayedPermanentCard target) and: [ 
				                 anotherPlayedPermanentCard target includesAll:
					                 target ] ]
		ifFalse: [ 
		targetMatches := target = anotherPlayedPermanentCard target ].

	^ self card = anotherPlayedPermanentCard card and: [ 
		  targetMatches ]
]

{ #category : #'applying effects' }
PlayedPermanentCard >> applyEffectsTo: spaceship using: anInitialValue [

	(target includes: spaceship) ifTrue: [ 
		^(card applyEffectsUsing: anInitialValue) ].
	^anInitialValue.
]

{ #category : #accessing }
PlayedPermanentCard >> card [

	^ card
]

{ #category : #initialization }
PlayedPermanentCard >> initializeUsing: aCard aimingAt: aTarget [

	card := aCard.
	target := aTarget.
]

{ #category : #accessing }
PlayedPermanentCard >> target [

	^ target
]
