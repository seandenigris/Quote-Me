Class {
	#name : #QuUnknownSource,
	#superclass : #Object,
	#instVars : [
		'authors'
	],
	#category : #'QuoteMe-Core'
}

{ #category : #'as yet unclassified' }
QuUnknownSource class >> by: authorCollection [

	^ self new setAuthors: authorCollection.
	
]

{ #category : #accessing }
QuUnknownSource >> author: person [

	authors := OrderedCollection with: person
]

{ #category : #accessing }
QuUnknownSource >> authors [

	^ authors ifNil: [ authors := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
QuUnknownSource >> printOn: aStream [
	self authors
		do: [ :e | aStream nextPutAll: e fullName ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ' (reference unknown)'
		
]

{ #category : #private }
QuUnknownSource >> setAuthors: authorsCollection [

	authors := authorsCollection.
	^ self.
]
