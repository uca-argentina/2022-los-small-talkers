Class {
	#name : #BlankSquare,
	#superclass : #Square,
	#instVars : [
		'playedReversePolarityCardCount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
BlankSquare >> = anotherBlankSquare [

	^(self className match: anotherBlankSquare className).
]

{ #category : #'Reverse Polarity Card handling' }
BlankSquare >> addReversePolarityCard: aReversePolarityCard [

	playedReversePolarityCardCount
		ifNil: [ playedReversePolarityCardCount := 1 ]
		ifNotNil: [ playedReversePolarityCardCount := 0 ]
]

{ #category : #'executing effects' }
BlankSquare >> applyEffectTo: spaceship from: game [
]

{ #category : #'executing effects' }
BlankSquare >> applyReverseEffectTo: spaceship from: game [
]

{ #category : #comparing }
BlankSquare >> hash [ 

	self className hash
]

{ #category : #'Reverse Polarity Card handling' }
BlankSquare >> playedReversePolarityCardCount [

	playedReversePolarityCardCount
		ifNil: [ ^ 0 ]
		ifNotNil: [ ^ playedReversePolarityCardCount ]
]
