Class {
	#name : #CardEffect,
	#superclass : #Object,
	#instVars : [
		'owner',
		'target',
		'payload'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardEffect class >> playedBy: someSpaceship itShouldSum: anAmount to: targets [ 

	^ self new initializePlayedBy: someSpaceship itShouldSum: anAmount to: targets
]

{ #category : #initialization }
CardEffect >> initializePlayedBy: someSpaceship itShouldSum: anAmount to: targets [

	owner := someSpaceship.
	payload := anAmount.
	target := targets.
]

{ #category : #accessing }
CardEffect >> owner [

	^ owner
]

{ #category : #accessing }
CardEffect >> payload [

	^ payload
]

{ #category : #accessing }
CardEffect >> target [

	^ target
]
