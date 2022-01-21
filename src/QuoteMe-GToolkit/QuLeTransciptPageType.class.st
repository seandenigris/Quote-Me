Class {
	#name : #QuLeTransciptPageType,
	#superclass : #LePageType,
	#instVars : [
		'modelID'
	],
	#classVars : [
		'ModelReferenceBuilder'
	],
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #'instance creation' }
QuLeTransciptPageType class >> eventID: aUUID page: aLePage [

	^ self new 
		modelID: aUUID;
		page: aLePage 
]

{ #category : #examples }
QuLeTransciptPageType class >> example [
	<gtExample>
	^ self exampleEmptyPage
		addSnippet: QuLeTranscriptLineSnippet exampleDumbledore;
		addSnippet: QuLeTranscriptLineSnippet exampleHarryPotter;
		yourself
]

{ #category : #examples }
QuLeTransciptPageType class >> exampleEmptyPage [
	<gtExample>
	
	| page model transcript |
	transcript := QuTranscript new.
	model := Object new.
	model stub ensureUUID willReturn: 1.
	model stub uuid willReturn: 1.
	model stub participants willReturn: #('Jack' 'Jill').
	model stub transcript willReturn: transcript.
	page := LePage quTranscriptOwnerID: model ensureUUID.
	LeDatabase new addPage: page.
	page type stub modelReference willReturn: (MADummyObjectUIDReferenceForTesting new
		object: model;
		uid: model uuid;
		yourself).
	^ page
]

{ #category : #accessing }
QuLeTransciptPageType class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#modelID -> #modelID);
		yourself

]

{ #category : #accessing }
QuLeTransciptPageType class >> leJsonV3Name [

	^ 'ppEventPage'
]

{ #category : #accessing }
QuLeTransciptPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#modelID -> #modelID);
		add: (#modelReference -> #modelReference);
		yourself

]

{ #category : #accessing }
QuLeTransciptPageType class >> leJsonV4Name [

	^ 'ppEventPage'
]

{ #category : #accessing }
QuLeTransciptPageType class >> modelReferenceBuilder [
	^ ModelReferenceBuilder
]

{ #category : #accessing }
QuLeTransciptPageType class >> modelReferenceBuilder: aValuable [
	"aValuable - returns anMAObjectUIDReference"
	ModelReferenceBuilder := aValuable
]

{ #category : #comparing }
QuLeTransciptPageType >> = anObject [
	"Answer whether the receiver and anObject represent the same page type."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ self modelID = anObject modelID
]

{ #category : #accessing }
QuLeTransciptPageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ self modelID
]

{ #category : #comparing }
QuLeTransciptPageType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self modelID hash
]

{ #category : #'api - testing' }
QuLeTransciptPageType >> isPpEventPageType [
	^ true
]

{ #category : #accessing }
QuLeTransciptPageType >> model [
	self modelID ifNil: [ ^ nil ].
	^ self modelReference object
]

{ #category : #accessing }
QuLeTransciptPageType >> modelID [

	^ modelID
]

{ #category : #accessing }
QuLeTransciptPageType >> modelID: anObject [

	modelID := anObject
]

{ #category : #accessing }
QuLeTransciptPageType >> modelReference [

	^ self class modelReferenceBuilder value
		uid: self modelID;
		yourself
]

{ #category : #printing }
QuLeTransciptPageType >> printOn: aStream [

	aStream
		<< 'PpEvent Page: ';
		<< (self model ifNotNil: #printString ifNil: [ '<none>' ])
]

{ #category : #accessing }
QuLeTransciptPageType >> snippetBuilder [
	^ QuLeTranscriptSnippetBuilder new
		parent: self page;
		database: self page database.
]

{ #category : #accessing }
QuLeTransciptPageType >> title [

	^ self model 
		ifNotNil: #displayString
		ifNil: [ 'PpEvent Page' ]
]
