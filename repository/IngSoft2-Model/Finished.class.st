Class {
	#name : #Finished,
	#superclass : #GameState,
	#category : #'IngSoft2-Model'
}

{ #category : #printing }
Finished >> isStarted [
	^false.
]

{ #category : #'determining game behaviour' }
Finished >> update: gameInstance [
	Error signal: 'Cannot start another turn in a finished game'.
]

{ #category : #'determining game behaviour' }
Finished >> winner: game [
	
	^game positionTracker winningSpaceship.
]
