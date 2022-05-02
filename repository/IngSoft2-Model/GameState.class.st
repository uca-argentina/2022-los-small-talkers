Class {
	#name : #GameState,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'asserting state' }
GameState >> isFinished [
	^ self subclassResponsibility.
]

{ #category : #'asserting state' }
GameState >> isStarted [
	^ self subclassResponsibility
]
