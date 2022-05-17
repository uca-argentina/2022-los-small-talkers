Class {
	#name : #TrenchRunSequence,
	#superclass : #Object,
	#instVars : [
		'elements',
		'counter'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrenchRunSequence class >> withAll: spaceships [
	^self new initializeWithAll: spaceships.
]

{ #category : #private }
TrenchRunSequence >> counterAdd [
	counter := counter + 1.
]

{ #category : #initialization }
TrenchRunSequence >> initializeWithAll: spaceships [
	elements := spaceships.
	counter := 0
]

{ #category : #accessing }
TrenchRunSequence >> nextInSequence [
	self counterAdd.
	^elements at: (((counter -1) \\ elements size)+1) .
]
