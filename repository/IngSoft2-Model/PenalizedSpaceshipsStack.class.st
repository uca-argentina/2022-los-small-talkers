Class {
	#name : #PenalizedSpaceshipsStack,
	#superclass : #Object,
	#instVars : [
		'penalizedSpaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
PenalizedSpaceshipsStack >> canPlayAgain: aSpaceship [

	penalizedSpaceships
		remove: aSpaceship
		ifAbsent: [ Error signal: 'Player is not a penalized spaceship' ]
]

{ #category : #testing }
PenalizedSpaceshipsStack >> checkEnabledToPlay: aSpaceship [

	^(penalizedSpaceships includes: aSpaceship) not
]

{ #category : #testing }
PenalizedSpaceshipsStack >> includes: aSpaceship [
    ^ penalizedSpaceships includes: aSpaceship
]

{ #category : #initialization }
PenalizedSpaceshipsStack >> initialize [ 

	super initialize.
	penalizedSpaceships := OrderedCollection new.
]

{ #category : #testing }
PenalizedSpaceshipsStack >> losesNextTurn: aSpaceship [

	penalizedSpaceships add: aSpaceship.
]
