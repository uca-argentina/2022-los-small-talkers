Class {
	#name : #BlankSlot,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BlankSlot class >> with: parameterObject [

	^self new.
]

{ #category : #'executing effects' }
BlankSlot >> applyEffectTo: aSpaceship from: aTrenchRunGameInstance [ 
	^self.
]
