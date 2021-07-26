Class {
	#name : #QuWebCitation,
	#superclass : #QuCitation,
	#instVars : [
		'name',
		'timestamp',
		'cache'
	],
	#category : #'QuoteMe-Core'
}

{ #category : #accessing }
QuWebCitation >> authors [
	self flag: 'What to do here. See super implementation'.
	^ #()
]

{ #category : #accessing }
QuWebCitation >> name [
	^ name
]

{ #category : #accessing }
QuWebCitation >> name: anObject [
	name := anObject
]

{ #category : #accessing }
QuWebCitation >> source: url [
	super source: url.
	cache := ZnClient new
		enforceHttpSuccess:true;
		get: self source.
	timestamp := DateAndTime now translateToUTC
]

{ #category : #'as yet unclassified' }
QuWebCitation >> timestamp [
	^ timestamp
]
