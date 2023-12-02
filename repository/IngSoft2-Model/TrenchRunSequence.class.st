Class {
	#name : #TrenchRunSequence,
	#superclass : #Object,
	#instVars : [
		'elements',
		'counter',
		'previous',
		'playerTurnCounter'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrenchRunSequence class >> withAll: sequenceableElements [
	^self new initializeWithAll: sequenceableElements.
]

{ #category : #comparing }
TrenchRunSequence >> = anotherTrenchRunSequence [

	^ elements = (anotherTrenchRunSequence elements)
]

{ #category : #private }
TrenchRunSequence >> counterAdd [

	counter := counter + 1
]

{ #category : #accessing }
TrenchRunSequence >> elements [

	^ elements
]

{ #category : #comparing }
TrenchRunSequence >> hash [ 
	
	^ elements hash
]

{ #category : #initialization }
TrenchRunSequence >> initializeWithAll: sequenceableElements [
	elements := sequenceableElements.
	counter := 0.
	playerTurnCounter := 0
]

{ #category : #accessing }
TrenchRunSequence >> next [
	
	self counterAdd.
	previous := elements at: counter - 1 \\ elements size + 1.
	^previous
]

{ #category : #'as yet unclassified' }
TrenchRunSequence >> nextPlayer [
	| index |
	self playerTurnCounterAdd.
    index := playerTurnCounter - 1 \\ elements size + 1.
    ^ elements at: index
]

{ #category : #'as yet unclassified' }
TrenchRunSequence >> nextPlayerName [
	| playerName |
    playerName := self nextPlayer.
    ^ playerName.
]

{ #category : #'as yet unclassified' }
TrenchRunSequence >> playerTurnCounterAdd [

	playerTurnCounter := playerTurnCounter +1
]

{ #category : #accessing }
TrenchRunSequence >> previous [

	previous ifNil: [ nil ].
	^ previous 
	
]
