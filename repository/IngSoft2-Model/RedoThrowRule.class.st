Class {
	#name : #RedoThrowRule,
	#superclass : #ThrowRule,
	#instVars : [
		'owner',
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RedoThrowRule class >> playedBy: spaceship in: game [

	^ self new initializePlayedBy: spaceship in: game.

	
]

{ #category : #initialization }
RedoThrowRule >> initializePlayedBy: aSpaceship in: aGame [

	owner := aSpaceship.
	game := aGame.
]

{ #category : #'card throwing' }
RedoThrowRule >> throwCard [

	game give: (game lastPlayedCard) toHandsOf: owner.
	self shouldBeImplemented.
]
