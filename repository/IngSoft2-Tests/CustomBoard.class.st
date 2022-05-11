Class {
	#name : #CustomBoard,
	#superclass : #Object,
	#instVars : [
		'length',
		'squares'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
CustomBoard class >> sized: aLength from: slotsDictionary [ 
	^ self new initilializeSized: aLength from: slotsDictionary.
]

{ #category : #'as yet unclassified' }
CustomBoard >> applyEffectTo: spaceship at: square from: game [

	(squares at: square) applyEffectTo: spaceship from: game.
]

{ #category : #initialization }
CustomBoard >> initilializeSized: aLength from: slotsDictionary [ 
	length := aLength.
	squares := slotsDictionary.
]

{ #category : #accessing }
CustomBoard >> length [
	^ length
]
