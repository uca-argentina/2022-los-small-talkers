Class {
	#name : #TrenchRunSequence,
	#superclass : #Object,
	#instVars : [
		'elements',
		'counter',
		'previous'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrenchRunSequence class >> withAll: sequenceableElements [
	^self new initializeWithAll: sequenceableElements.
]

{ #category : #private }
TrenchRunSequence >> counterAdd [

	counter := counter + 1
]

{ #category : #initialization }
TrenchRunSequence >> initializeWithAll: sequenceableElements [
	elements := sequenceableElements.
	counter := 0
]

{ #category : #accessing }
TrenchRunSequence >> next [
	
	self counterAdd.
	previous := elements at: counter - 1 \\ elements size + 1.
	^previous
]

{ #category : #accessing }
TrenchRunSequence >> previous [

	previous ifNil: [ Error signal: 'Trying to access previous element in sequence when inexistent' ].
	^ previous 
	
]
