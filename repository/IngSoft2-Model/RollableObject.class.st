Class {
	#name : #RollableObject,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
RollableObject >> maxResult [

	self subclassResponsibility
]

{ #category : #rolling }
RollableObject >> roll [

	self subclassResponsibility
]
