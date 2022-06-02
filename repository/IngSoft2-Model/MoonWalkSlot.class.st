Class {
	#name : #MoonWalkSlot,
	#superclass : #SuperclassSlot,
	#instVars : [
		'amountToMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkSlot class >> with: retrogression [
	| n |
	n := retrogression at: 'N' ifAbsent: [ 
		             Error signal:
			             'Missing N parameter on MoonWalkSlot creation' ].

	(n < 0 ) ifTrue: [ n := (0 - n) ].
	
	^ self new initializeWith: n
]

{ #category : #'executing effects' }
MoonWalkSlot >> applyEffectTo: spaceship from: game [

	| posiciones length spaceshipsToMove |
	posiciones := game spaceships.
	spaceshipsToMove := posiciones.
	spaceshipsToMove remove: spaceship.
	length := spaceshipsToMove size.
	(1 to: length by: 1) do: [ :i | 
		game move: (spaceshipsToMove at: i) anAmountOf: 0 - amountToMove ]
]

{ #category : #initialization }
MoonWalkSlot >> initializeWith: n [

	amountToMove := n
]
