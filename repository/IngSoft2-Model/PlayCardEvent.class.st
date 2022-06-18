Class {
	#name : #PlayCardEvent,
	#superclass : #Object,
	#instVars : [
		'card',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
PlayCardEvent class >> using: aCard aimedAt: someTarget [

	^ self new initializeUsing: aCard aimedAt: someTarget .
]

{ #category : #comparing }
PlayCardEvent >> = anotherPlayCardEvent [

	^ self card = anotherPlayCardEvent card and: [ 
		  self target = anotherPlayCardEvent target ]
]

{ #category : #accessing }
PlayCardEvent >> card [

	^ card
]

{ #category : #comparing }
PlayCardEvent >> hash [ 

	^( card hash bitXor: ( target hash ))
]

{ #category : #accessing }
PlayCardEvent >> initializeUsing: aCard aimedAt: someTarget [

	card := aCard.
	target := someTarget.
]

{ #category : #accessing }
PlayCardEvent >> target [

	^ target
]
