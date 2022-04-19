Class {
	#name : #Leaderboard,
	#superclass : #Object,
	#instVars : [
		'records'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Leaderboard class >> withShip: aSpaceship [ 
	^self new initializeWithSpaceships: { aSpaceship }.
]

{ #category : #'instance creation' }
Leaderboard class >> withSpaceships: aCollectionOfSpaceships [
	^self new initializeWithSpaceships: aCollectionOfSpaceships.
]

{ #category : #deleting }
Leaderboard >> deleteRecordOf: aSpaceship [ 
	|foundRecord|
	foundRecord := self recordOf: aSpaceship  ifAbsent: [ Error signal: 'Cannot delete record of unknown ship'. ].
	
	records remove: foundRecord ifAbsent: [].
]

{ #category : #initialization }
Leaderboard >> initializeWithSpaceships: aCollectionOfSpaceships [
	
	records := OrderedCollection withAll: (aCollectionOfSpaceships collect: [ :ship |
		LeaderboardRecord withShip: ship atSquare: 1.	
	]).
]

{ #category : #moving }
Leaderboard >> move: aSpaceship forwardSquares: anInteger then: aFinishingCleanupBlock [
	
	|shipRecord currentPosition nextPosition|
	shipRecord := self recordOf: aSpaceship ifAbsent: [
		Error signal: 'Cannot move an unregistered ship'.
	].
	
	currentPosition := shipRecord square.
	
	nextPosition := currentPosition + anInteger.
	
	self deleteRecordOf: aSpaceship.
	
	records add: (LeaderboardRecord withShip: aSpaceship atSquare: nextPosition).
	
	(aFinishingCleanupBlock argumentCount = 1) ifTrue: [ aFinishingCleanupBlock value: nextPosition . ].
	(aFinishingCleanupBlock argumentCount = 0) ifTrue: [ aFinishingCleanupBlock value. ]
]

{ #category : #accessing }
Leaderboard >> players [
	
	^ records collect: [ :record | 
		record ship.
	]
]

{ #category : #accessing }
Leaderboard >> ranking [
	|keys values|
	keys := records collect: [ :record | 
		record ship.
	].

	values := records collect: [ :record | 
		record square.
	].

	^Dictionary newFromKeys: keys andValues: values.
]

{ #category : #accessing }
Leaderboard >> recordOf: aSpaceship ifAbsent: aFullBlockClosure [ 
	|matchingResults|
	
	matchingResults := records select: [ :record |
		record ship = aSpaceship.
	].

	(matchingResults isEmpty) ifTrue: [ aFullBlockClosure value. ] ifFalse: [ ^matchingResults at: 1 ].
]

{ #category : #accessing }
Leaderboard >> winningSpaceship [ 
	
	^ (records detectMax: [:shipSquarePair | shipSquarePair square]) ship.
]
