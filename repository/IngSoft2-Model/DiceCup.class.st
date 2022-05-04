Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceCup class >> with: die [
	
	^self new initializeWithAll: { die }.
]

{ #category : #'instance creation' }
DiceCup class >> withAll: dice [
	
	^self new initializeWithAll: dice.
]

{ #category : #initialization }
DiceCup >> initializeWithAll: diceVar [

	dice := diceVar.
]

{ #category : #rolling }
DiceCup >> roll [

	^ dice sum: [:die | die roll ].
]
