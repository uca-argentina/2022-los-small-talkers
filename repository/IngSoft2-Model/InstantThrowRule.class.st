Class {
	#name : #InstantThrowRule,
	#superclass : #ThrowRule,
	#instVars : [
		'card',
		'owner',
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
InstantThrowRule class >> of: card playedBy: spaceship in: game [

	^ self new initializeOf: card playedBy: spaceship in: game.
]

{ #category : #initialization }
InstantThrowRule >> initializeOf: aCard playedBy: aSpaceship in: aGame [

	card := aCard.
	owner := aSpaceship.
	game := aGame.
]

{ #category : #'card throwing' }
InstantThrowRule >> throwCard [ 

	self shouldBeImplemented
]
