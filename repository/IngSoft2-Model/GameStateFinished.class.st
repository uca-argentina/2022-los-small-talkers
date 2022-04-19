Class {
	#name : #GameStateFinished,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #printing }
GameStateFinished >> printState [
	^'finished'.
]

{ #category : #'determining game behaviour' }
GameStateFinished >> update: gameInstance [
	Error signal: 'Cannot start another turn in a finished game'.
]

{ #category : #'determining game behaviour' }
GameStateFinished >> winner: game [
	
	^game winningSpaceship.
]
