Class {
	#name : #GameStateNotStarted,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #printing }
GameStateNotStarted >> printState [ 
	^'not started'.
]

{ #category : #updating }
GameStateNotStarted >> update: game [
	game start.
]
