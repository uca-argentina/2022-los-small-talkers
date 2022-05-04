Class {
	#name : #TrenchRunSpaceshipSequence,
	#superclass : #Object,
	#instVars : [
		'elements',
		'counter'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrenchRunSpaceshipSequence class >> withAll: spaceships [
	^self new initializeWithAll: spaceships.
]

{ #category : #private }
TrenchRunSpaceshipSequence >> counterAdd [
	counter := counter + 1.
]

{ #category : #initialization }
TrenchRunSpaceshipSequence >> initializeWithAll: spaceships [
	elements := spaceships.
	counter := 0
]

{ #category : #accessing }
TrenchRunSpaceshipSequence >> nextInSequence [
	self counterAdd.
	^elements at: (((counter -1) \\ elements size)+1) .
]
