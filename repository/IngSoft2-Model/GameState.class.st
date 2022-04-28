Class {
	#name : #GameState,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
GameState >> isStarted [
	^ self subclassResponsibility
]
