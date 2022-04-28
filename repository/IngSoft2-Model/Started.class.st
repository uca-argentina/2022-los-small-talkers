Class {
	#name : #Started,
	#superclass : #GameState,
	#category : #'IngSoft2-Model'
}

{ #category : #printing }
Started >> isStarted [ 
	^true.
]

{ #category : #'determining game behaviour' }
Started >> update: game [
]

{ #category : #'determining game behaviour' }
Started >> winner: game [

	Error signal: [ 'There cannot be a winner if the game has not finished' ]
]
