Class {
	#name : #PermanentThrowRule,
	#superclass : #ThrowRule,
	#instVars : [
		'card',
		'owner',
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PermanentThrowRule class >> of: card playedBy: spaceship in: game [

	game turnHandler currentSpaceshipTurn = spaceship ifFalse: [ 
		Error signal: 'Cannot play permanent card when not in the spaceships turn' ].

	^ self new initializeOf: card playedBy: spaceship in: game
]

{ #category : #initialization }
PermanentThrowRule >> initializeOf: aCard playedBy: aSpaceship in: aGame [

	card := aCard.
	owner := aSpaceship.
	game := aGame.
]

{ #category : #'card throwing' }
PermanentThrowRule >> throwCard [ 

	self shouldBeImplemented
]
