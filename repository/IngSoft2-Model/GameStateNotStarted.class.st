Class {
	#name : #GameStateNotStarted,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #printing }
GameStateNotStarted >> printState [ 
	^'not started'.
]

{ #category : #'determining game behaviour' }
GameStateNotStarted >> update: game [
	game start.
]

{ #category : #'determining game behaviour' }
GameStateNotStarted >> winner: game [

	^nil.
]
