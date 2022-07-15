Class {
	#name : #Finished,
	#superclass : #GameState,
	#category : #'IngSoft2-Model'
}

{ #category : #'asserting state' }
Finished >> isFinished [

	^ true
]

{ #category : #'asserting state' }
Finished >> isStarted [

	^ false
]

{ #category : #updating }
Finished >> update: gameInstance [

	Error signal: 'Cannot start another turn in a finished game'
]

{ #category : #'determining game behaviour' }
Finished >> winner: game [

	^ game positionTracker currentLeader
]
