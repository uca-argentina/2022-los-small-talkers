Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceCup class >> withAll: givenDice [

	^ self new initializeWithAll: givenDice
]

{ #category : #initialization }
DiceCup >> initializeWithAll: givenDice [

	dice := givenDice
]

{ #category : #rolling }
DiceCup >> roll [

	^ dice sum: [:die | die roll ].
]
