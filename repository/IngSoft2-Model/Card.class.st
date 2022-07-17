Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Card class >> ownedBy: aSpaceship [

	self subclassResponsibility
]

{ #category : #comparing }
Card >> = anotherCard [

	self subclassResponsibility
]

{ #category : #comparing }
Card >> hash [ 

	self subclassResponsibility
]

{ #category : #initialization }
Card >> initializeOwnedBy: aSpaceship [

	self subclassResponsibility
]

{ #category : #accessing }
Card >> owner [

	self subclassResponsibility 
]
