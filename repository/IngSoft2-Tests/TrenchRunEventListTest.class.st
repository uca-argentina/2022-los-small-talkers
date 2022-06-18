Class {
	#name : #TrenchRunEventListTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
TrenchRunEventListTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^ self
		  should: aBlock
		  raise: anErrorType
		  whoseDescriptionIncludes: anErrorMessage
		  description: 'Test did not fail for expected reason'
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastCardEventInACardOnlyEventListReturnsTheLastCardEvent [

	| trenchRunEventList enterprise planetExpress |
	enterprise := 'Enterprise'.
	planetExpress := 'Planet Express'.
	trenchRunEventList := Event_TrenchRunEventList new.
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (SpeedCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (CancellationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 SpeedCard }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (AccelerationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (OverloadCard ownedBy: enterprise)
			 aimedAt: { planetExpress }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (RedoCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (RepeatCard ownedBy: enterprise)
			 aimedAt: { enterprise }).

	self
		assert: trenchRunEventList lastCardIsPlayedEvent
		equals: (Event_CardIsPlayed
				 using: (RepeatCard ownedBy: enterprise)
				 aimedAt: { enterprise }).

	self
		assert: trenchRunEventList lastCardIsPlayedEvent hash
		equals: (Event_CardIsPlayed
				 using: (RepeatCard ownedBy: enterprise)
				 aimedAt: { enterprise }) hash
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastCardEventInALandsOnSquareOnlyEventListThrowsError [

	| trenchRunEventList enterprise planetExpress |
	enterprise := 'Enterprise'.
	planetExpress := 'Planet Express'.
	trenchRunEventList := Event_TrenchRunEventList new.
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: BlankSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: DrawCardSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: AtomicBombSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: SpeedUpSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: HyperJumpSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: WormHoleSquare new).

	self
		should: [ trenchRunEventList lastCardIsPlayedEvent ]
		raise: Error
		withMessage:
		'Trying to access last played card event when none ever happened'
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastCardEventInAMixedEventListReturnsTheLastCardEvent [

	| trenchRunEventList enterprise planetExpress |
	enterprise := 'Enterprise'.
	planetExpress := 'Planet Express'.
	trenchRunEventList := Event_TrenchRunEventList new.
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (SpeedCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (CancellationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 SpeedCard }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (AccelerationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (OverloadCard ownedBy: enterprise)
			 aimedAt: { planetExpress }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (RedoCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (RepeatCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: BlankSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: DrawCardSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: AtomicBombSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: SpeedUpSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: HyperJumpSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: WormHoleSquare new).

	self
		assert: trenchRunEventList lastCardIsPlayedEvent
		equals: (Event_CardIsPlayed
				 using: (RepeatCard ownedBy: enterprise)
				 aimedAt: { enterprise }).

	self
		assert: trenchRunEventList lastCardIsPlayedEvent hash
		equals: (Event_CardIsPlayed
				 using: (RepeatCard ownedBy: enterprise)
				 aimedAt: { enterprise }) hash
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastEventInACardOnlyEventListReturnsTheLastCardEvent [

	| trenchRunEventList enterprise planetExpress |
	enterprise := 'Enterprise'.
	planetExpress := 'Planet Express'.
	trenchRunEventList := Event_TrenchRunEventList new.
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (SpeedCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (CancellationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 SpeedCard }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (AccelerationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (OverloadCard ownedBy: enterprise)
			 aimedAt: { planetExpress }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (RedoCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (RepeatCard ownedBy: enterprise)
			 aimedAt: { enterprise }).

	self assert: trenchRunEventList lastEvent equals: (Event_CardIsPlayed
			 using: (RepeatCard ownedBy: enterprise)
			 aimedAt: { enterprise }).

	self
		assert: trenchRunEventList lastCardIsPlayedEvent hash
		equals: (Event_CardIsPlayed
				 using: (RepeatCard ownedBy: enterprise)
				 aimedAt: { enterprise }) hash
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastEventInALandsOnSquareOnlyEventListReturnsTheLastLandsOnSquareEvent [

	| trenchRunEventList enterprise planetExpress |
	enterprise := 'Enterprise'.
	planetExpress := 'Planet Express'.
	trenchRunEventList := Event_TrenchRunEventList new.
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: BlankSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: DrawCardSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: AtomicBombSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: SpeedUpSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: HyperJumpSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: WormHoleSquare new).

	self
		assert: trenchRunEventList lastEvent
		equals:
		(Event_LandsOnSquare from: enterprise landsOn: WormHoleSquare new).

	self
		assert: trenchRunEventList lastEvent hash
		equals:
		(Event_LandsOnSquare from: enterprise landsOn: WormHoleSquare new)
			hash
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastLandsOnSquareEventInACardOnlyEventListThrowsError [

	| trenchRunEventList enterprise planetExpress |
	enterprise := 'Enterprise'.
	planetExpress := 'Planet Express'.
	trenchRunEventList := Event_TrenchRunEventList new.
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (SpeedCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (CancellationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 SpeedCard }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (AccelerationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (OverloadCard ownedBy: enterprise)
			 aimedAt: { planetExpress }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (RedoCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (RepeatCard ownedBy: enterprise)
			 aimedAt: { enterprise }).

	self
		should: [ trenchRunEventList lastLandsOnSquareEvent ]
		raise: Error
		withMessage:
		'Trying to access last lands on square event when none ever happened'
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastLandsOnSquareEventInALandsOnSquareOnlyEventListReturnsTheLastLandsOnSquareEvent [

	| trenchRunEventList enterprise planetExpress |
	enterprise := 'Enterprise'.
	planetExpress := 'Planet Express'.
	trenchRunEventList := Event_TrenchRunEventList new.
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: BlankSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: DrawCardSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: AtomicBombSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: SpeedUpSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: HyperJumpSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: WormHoleSquare new).

	self
		assert: trenchRunEventList lastEvent
		equals:
		(Event_LandsOnSquare from: enterprise landsOn: WormHoleSquare new)
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastLandsOnSquareEventInAMixedEventListReturnsTheLastLandsOnSquareEvent [

	| trenchRunEventList enterprise planetExpress |
	enterprise := 'Enterprise'.
	planetExpress := 'Planet Express'.
	trenchRunEventList := Event_TrenchRunEventList new.
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: BlankSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: DrawCardSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: AtomicBombSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: SpeedUpSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: HyperJumpSquare new).
	trenchRunEventList add:
		(Event_LandsOnSquare from: enterprise landsOn: WormHoleSquare new).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (SpeedCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (CancellationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 SpeedCard }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (AccelerationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (OverloadCard ownedBy: enterprise)
			 aimedAt: { planetExpress }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (RedoCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (Event_CardIsPlayed
			 using: (RepeatCard ownedBy: enterprise)
			 aimedAt: { enterprise }).

	self
		assert: trenchRunEventList lastLandsOnSquareEvent
		equals:
		(Event_LandsOnSquare from: enterprise landsOn: WormHoleSquare new)
]
