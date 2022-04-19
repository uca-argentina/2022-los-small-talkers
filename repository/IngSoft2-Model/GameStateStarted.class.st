Class {
	#name : #GameStateStarted,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #printing }
GameStateStarted >> printState [ 
	^'started'.
]

{ #category : #'determining game behaviour' }
GameStateStarted >> update: game [
]

{ #category : #'determining game behaviour' }
GameStateStarted >> winner: game [

	^nil.
]
