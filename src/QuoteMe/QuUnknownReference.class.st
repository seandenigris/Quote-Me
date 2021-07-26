Class {
	#name : #QuUnknownReference,
	#superclass : #Object,
	#instVars : [
		'authors'
	],
	#category : 'QuoteMe-Core'
}

{ #category : #'as yet unclassified' }
QuUnknownReference class >> by: authorCollection [

	^ self new setAuthors: authorCollection.
	
]

{ #category : #accessing }
QuUnknownReference >> authors [

	^ authors ifNil: [ authors := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
QuUnknownReference >> printOn: aStream [
	self authors
		do: [ :e | aStream nextPutAll: e fullName ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ' (reference unknown)'
		
]

{ #category : #private }
QuUnknownReference >> setAuthors: authorsCollection [

	authors := authorsCollection.
	^ self.
]
