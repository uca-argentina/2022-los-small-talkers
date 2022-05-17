Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'totalParsecs',
		'totalSquares'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValid: aLength [
	aLength > 1 ifFalse: [ 
		Error signal: 'Boards need a minimum length of 1' ].
]

{ #category : #'instance creation' }
Board class >> sized: someSquares dividedIn: someParsecs [

	self assertValid: someParsecs.
	self assertValid: someSquares.
	^ self new initializeSized: someSquares dividedIn: someParsecs
]

{ #category : #'instance creation' }
Board class >> sized: someSquares dividedIn: someParsecs from: slotSquareDictionary [

	self assertValid: someParsecs.
	self assertValid: someSquares.
	^ self new
		  initializeSized: someSquares
		  dividedIn: someParsecs
		  from: slotSquareDictionary
]

{ #category : #'executing effects' }
Board >> applyEffectTo: spaceship at: square from: game [

	(squares at: square) applyEffectTo: spaceship from: game.
]

{ #category : #initialization }
Board >> initializeSized: someSquares dividedIn: someParsecs [

	| creationParameters |
	totalSquares := someSquares.
	totalParsecs := someParsecs.
	creationParameters := { 
		                      ('Nmax' -> 5).
		                      ('Mmax' -> 5).
		                      ('Mamount' -> 3) } asDictionary.
	squares := (RandomSquaresGenerator
		            creating: { 
				            AtomicBombSlot.
				            HyperJumpSlot.
				            MoonWalkSlot.
				            SpeedUpSlot.
				            WormHoleSlot.
				            BlankSlot }
		            with: { 
				            (2 / 100).
				            (8 / 100).
				            (1 / 10).
				            (2 / 10).
				            (2 / 10).
				            (4 / 10) }
		            sized: someSquares
		            accordingTo: creationParameters) generateSlots
]

{ #category : #initialization }
Board >> initializeSized: someSquares dividedIn: someParsecs from: slotSquareDictionary [

	totalSquares := someSquares.
	totalParsecs := someParsecs.
	squares := slotSquareDictionary isEmpty
		           ifTrue: [ 
			           OrderedCollection newFrom:
				           ((1 to: someSquares by: 1) collect: [ :i | 
					            BlankSlot new ]) ]
		           ifFalse: [ 
			           OrderedCollection newFrom:
				           ((1 to: someSquares by: 1) collect: [ :i | 
					            slotSquareDictionary
						            at: i
						            ifAbsentPut: [ BlankSlot new ] ]) ]
]

{ #category : #'accessing - attributes' }
Board >> length [

	^ totalSquares
]

{ #category : #accessing }
Board >> squaresPerParsec [

	^ totalSquares / totalParsecs
]
