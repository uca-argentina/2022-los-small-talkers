Class {
	#name : #PlayCardEvent,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'card',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
PlayCardEvent class >> from: aSpaceship using: aCard aimedAt: someTarget [

	^ self new initializeFrom: aSpaceship using: aCard aimedAt: someTarget .
]

{ #category : #comparing }
PlayCardEvent >> = anotherPlayCardEvent [

	^ self card = anotherPlayCardEvent card and: [ self spaceship = anotherPlayCardEvent spaceship and: [ self target = anotherPlayCardEvent target ] ]
]

{ #category : #accessing }
PlayCardEvent >> card [

	^ card
]

{ #category : #comparing }
PlayCardEvent >> hash [ 

	^ card hash bitXor: [ spaceship hash bitXor: [ target hash ] ]
]

{ #category : #accessing }
PlayCardEvent >> initializeFrom: aSpaceship using: aCard aimedAt: someTarget [

	spaceship := aSpaceship.
	card := aCard.
	target := someTarget.
]

{ #category : #accessing }
PlayCardEvent >> spaceship [ 

	^ spaceship.
]

{ #category : #accessing }
PlayCardEvent >> target [

	^ target
]
