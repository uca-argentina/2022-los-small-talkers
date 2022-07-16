Class {
	#name : #DiceCup,
	#superclass : #RollableObject,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceCup class >> withAll: givenDice [

	^ self new initializeWithAll: givenDice
]

{ #category : #arithmetic }
DiceCup >> + anotherRollableObject [

	^ DiceCup withAll: { self. anotherRollableObject }.
]

{ #category : #initialization }
DiceCup >> initializeWithAll: givenDice [

	dice := givenDice
]

{ #category : #accessing }
DiceCup >> maxResult [ 

	^ dice sum: [ :die | die maxResult ] ifEmpty: 0.
]

{ #category : #rolling }
DiceCup >> roll [

	^ dice sum: [:die | die roll ].
]
