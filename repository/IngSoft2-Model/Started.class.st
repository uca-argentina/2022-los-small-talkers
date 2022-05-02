Class {
	#name : #Started,
	#superclass : #GameState,
	#category : #'IngSoft2-Model'
}

{ #category : #'asserting state' }
Started >> isFinished [ 

	^false
]

{ #category : #'asserting state' }
Started >> isStarted [ 
	^true.
]

{ #category : #updating }
Started >> update: game [

	^ self
]

{ #category : #'determining game behaviour' }
Started >> winner: game [

	Error signal: 'There cannot be a winner if the game has not finished'.
]
