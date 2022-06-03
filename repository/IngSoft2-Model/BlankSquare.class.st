Class {
	#name : #BlankSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
BlankSquare class >> createAtRandom [

	^self new
]

{ #category : #'executing effects' }
BlankSquare >> applyEffectTo: aSpaceship from: aTrenchRunGameInstance [ 
	^self.
]
