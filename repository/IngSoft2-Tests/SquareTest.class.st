Class {
	#name : #SquareTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SquareTest >> testAtomicBombSquareEqualsAnotherAtomicBombSquare [

	self assert: AtomicBombSquare new equals: AtomicBombSquare new.
	self assert: AtomicBombSquare new hash equals: AtomicBombSquare new hash
]

{ #category : #tests }
SquareTest >> testBlankSquareEqualsAnotherBlankSquare [

	self assert: BlankSquare new equals: BlankSquare new.
	self assert: BlankSquare new hash equals: BlankSquare new hash
]

{ #category : #tests }
SquareTest >> testDrawCardSquareEqualsAnotherDrawCardSquare [

	self assert: DrawCardSquare new equals: DrawCardSquare new.
	self assert: DrawCardSquare new hash equals: DrawCardSquare new hash
]

{ #category : #tests }
SquareTest >> testHyperJumpSquareEqualsAnotherHyperJumpSquare [

	self
		assert: (HyperJumpSquare with: { (Parsec amounting: 10) })
		equals: (HyperJumpSquare with: { (Parsec amounting: 10) }).
	self
		assert: (HyperJumpSquare with: { (Parsec amounting: 10) }) hash
		equals: (HyperJumpSquare with: { (Parsec amounting: 10) }) hash.
	self
		assert: (HyperJumpSquare with: { (LightYear amounting: 10) })
		equals: (HyperJumpSquare with: { (LightYear amounting: 10) }).
	self
		assert: (HyperJumpSquare with: { (LightYear amounting: 10) }) hash
		equals: (HyperJumpSquare with: { (LightYear amounting: 10) }) hash
]

{ #category : #tests }
SquareTest >> testJailSquareEqualsAnotherJailSquare [

	self assert: JailSquare new equals: JailSquare  new.
	self assert: JailSquare  new hash equals: JailSquare new hash
]

{ #category : #tests }
SquareTest >> testMoonWalkSquareEqualsAnotherMoonWalkSquare [

	self
		assert: (MoonWalkSquare with: 10)
		equals: (MoonWalkSquare with: 10).
	self
		assert: (MoonWalkSquare with: 10) hash
		equals: (MoonWalkSquare with: 10) hash
]

{ #category : #tests }
SquareTest >> testNewMethodInHyperJumpSquareCreatesAValidRandomizedInstanceWithAValidJumpSequence [

	|square|
	square := HyperJumpSquare new.
	self assert: (square jumpSequence) className equals: 'TrenchRunSequence'  
]

{ #category : #tests }
SquareTest >> testNewMethodInMoonWalkSquareCreatesAValidRandomizedInstanceWithAValidRetrogressionParameter [

	| square |
	square := MoonWalkSquare new.
	self assert: square retrogression isNumber 
]

{ #category : #tests }
SquareTest >> testSpeedUpSquareEqualsAnotherSpeedUpSquare [

	self
		assert: (SpeedUpSquare new)
		equals: (SpeedUpSquare new).
	self
		assert:(SpeedUpSquare new) hash
		equals: (SpeedUpSquare new) hash
]

{ #category : #tests }
SquareTest >> testWormHoleSquareEqualsAnotherWormHoleSquare [

	self assert: WormHoleSquare new equals: WormHoleSquare new.
	self assert: WormHoleSquare new hash equals: WormHoleSquare new hash
]
