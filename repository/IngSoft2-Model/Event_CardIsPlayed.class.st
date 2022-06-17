Class {
	#name : #'Event_CardIsPlayed',
	#superclass : #Object,
	#instVars : [
		'card',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Event_CardIsPlayed class >> using: aCard aimedAt: someTarget [

	^ self new initializeUsing: aCard aimedAt: someTarget .
]

{ #category : #comparing }
Event_CardIsPlayed >> = anotherPlayCardEvent [

	^ self card = anotherPlayCardEvent card and: [ 
		  self target = anotherPlayCardEvent target ]
]

{ #category : #accessing }
Event_CardIsPlayed >> card [

	^ card
]

{ #category : #comparing }
Event_CardIsPlayed >> hash [ 

	^( card hash bitXor: ( target hash ))
]

{ #category : #accessing }
Event_CardIsPlayed >> initializeUsing: aCard aimedAt: someTarget [

	card := aCard.
	target := someTarget.
]

{ #category : #accessing }
Event_CardIsPlayed >> target [

	^ target
]
