Class {
	#name : #GameStateFinished,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #printing }
GameStateFinished >> printState [
	^'finished'.
]

{ #category : #updating }
GameStateFinished >> update: gameInstance [
	Error signal: 'Cannot start another turn in a finished game'.
]

