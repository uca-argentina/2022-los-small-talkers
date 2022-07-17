Class {
	#name : #TrenchRunSequence,
	#superclass : #Object,
	#instVars : [
		'elements',
		'counter',
		'previous',
		'current'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrenchRunSequence class >> withAll: sequenceableElements [
	^self new initializeWithAll: sequenceableElements.
]

{ #category : #comparing }
TrenchRunSequence >> = anotherTrenchRunSequence [

	^ elements = (anotherTrenchRunSequence elements)
]

{ #category : #private }
TrenchRunSequence >> counterAdd [

	counter := (counter \\ (elements size)) + 1
]

{ #category : #accessing }
TrenchRunSequence >> current [

	^ current
]

{ #category : #accessing }
TrenchRunSequence >> elements [

	^ elements
]

{ #category : #comparing }
TrenchRunSequence >> hash [ 
	
	^ elements hash
]

{ #category : #initialization }
TrenchRunSequence >> initializeWithAll: sequenceableElements [

	elements := sequenceableElements asOrderedCollection.
	counter := 0
]

{ #category : #accessing }
TrenchRunSequence >> next [

	self counterAdd.
	previous := current.
	current := elements at: counter.
	^ current
]

{ #category : #'repeating last' }
TrenchRunSequence >> repeatLastOnNext [

	counter := counter -1
]

{ #category : #converting }
TrenchRunSequence >> reversed [

	| newSequence |
	newSequence := self class withAll: elements reversed.
	newSequence skipTo: current.
	^ newSequence
]

{ #category : #'sequence skipping' }
TrenchRunSequence >> skipTo: sequenceableElement [

	| wantedObjectIndex |
	wantedObjectIndex := self elements
		                     indexOf: sequenceableElement
		                     ifAbsent: [ 
		                     Error signal: 'Element not in sequence' ].
	(wantedObjectIndex - counter) timesRepeat: [self next]
]
