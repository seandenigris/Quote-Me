"
The problem with creating an instance is that a particular model object may not know how to create a reference to itself. In fact, it probably doesn't. An Event, for example, might live in a log, but what log? And we can't hardcode the assumptions of the library about where events live because another library using the first may make different assumptions.

Thus, we provide a class-side map for libraries to configure how to construct a reference for a particular class. The configuration can be edited via {{gtMethod:QuLeTransciptPageType class>>#modelReferenceForClass:builder:}}
"
Class {
	#name : #QuLeTranscriptPageType,
	#superclass : #LePageType,
	#instVars : [
		'subjectModelReference'
	],
	#classVars : [
		'ModelReferenceBuilder',
		'ModelReferenceBuilderMap'
	],
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #examples }
QuLeTranscriptPageType class >> example [
	<gtExample>
	^ self exampleEmptyPage
		addSnippet: QuLeTranscriptLineSnippet exampleDumbledore;
		addSnippet: QuLeTranscriptLineSnippet exampleHarryPotter;
		yourself
]

{ #category : #examples }
QuLeTranscriptPageType class >> exampleEmptyPage [
	<gtExample>
	
	| page model transcript |
	transcript := QuTranscript new.
	model := Object new.
	model stub ensureUUID willReturn: 1.
	model stub uuid willReturn: 1.
	model stub participants willReturn: #('Jack' 'Jill').
	model stub transcript willReturn: transcript.
	self modelReferenceBuilderMap at: Object put: [MADummyObjectUIDReferenceForTesting new
		object: model;
		uid: model uuid;
		yourself ].
	[ 
		page := LePage quTranscriptOwner: model.
	] ensure: [ self modelReferenceBuilderMap removeKey: Object ].
	LeDatabase new addPage: page.
	^ page
]

{ #category : #initialization }
QuLeTranscriptPageType class >> initialize [

	LeDatabasesRegistry defaultPrimaryDatabase updatePageTypes
]

{ #category : #accessing }
QuLeTranscriptPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#subjectModelReference -> #subjectModelReference);
		yourself
]

{ #category : #accessing }
QuLeTranscriptPageType class >> leJsonV4Name [

	^ 'quTranscriptPage'
]

{ #category : #accessing }
QuLeTranscriptPageType class >> modelReferenceBuilderMap [

	^ ModelReferenceBuilderMap ifNil: [ ModelReferenceBuilderMap := Dictionary new ]
]

{ #category : #accessing }
QuLeTranscriptPageType class >> modelReferenceBuilderMap: anObject [

	^ ModelReferenceBuilderMap := anObject
]

{ #category : #accessing }
QuLeTranscriptPageType class >> modelReferenceForClass: aClass [
	^ self modelReferenceBuilderMap 
		at: aClass
		ifAbsent: [ 
			aClass superclass
				ifNotNil: [ :supr | self modelReferenceForClass: supr ]
				ifNil: [ self error: 'no builder for ', aClass name ] ]
]

{ #category : #accessing }
QuLeTranscriptPageType class >> modelReferenceForClass: aClass builder: aValuable [
	^ self modelReferenceBuilderMap at: aClass put: aValuable
]

{ #category : #'instance creation' }
QuLeTranscriptPageType class >> subjectModel: anObject page: aLePage [
	| referenceBuilder reference |
	referenceBuilder := self modelReferenceForClass: anObject class.
	reference := referenceBuilder value
		uid: anObject ensureUUID;
		yourself.
	^ self new
		subjectModelReference: reference;
		page: aLePage;
		yourself.
]

{ #category : #comparing }
QuLeTranscriptPageType >> = anObject [
	"Answer whether the receiver and anObject represent the same page type."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ self subjectModelID = anObject subjectModelID
]

{ #category : #accessing }
QuLeTranscriptPageType >> asContentUIModel [
	^ QuLeTranscriptPageViewModel new pageModel: self page
]

{ #category : #accessing }
QuLeTranscriptPageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ self subjectModelID
]

{ #category : #comparing }
QuLeTranscriptPageType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self subjectModelID hash
]

{ #category : #'api - testing' }
QuLeTranscriptPageType >> isQuTranscriptPageType [
	^ true
]

{ #category : #accessing }
QuLeTranscriptPageType >> newPlayer [
	^ self subjectModel newPlayer
]

{ #category : #accessing }
QuLeTranscriptPageType >> pageElementClass [
	^ QuLeTranscriptPageElement
]

{ #category : #printing }
QuLeTranscriptPageType >> printOn: aStream [

	aStream
		<< 'QuTranscript Page: ';
		<< (self subjectModel ifNotNil: #printString ifNil: [ '<none>' ])
]

{ #category : #accessing }
QuLeTranscriptPageType >> snippetBuilder [
	^ QuLeTranscriptSnippetBuilder new
		parent: self page;
		database: self page database.
]

{ #category : #accessing }
QuLeTranscriptPageType >> subjectModel [
	self subjectModelReference ifNil: [ ^ nil ].
	^ self subjectModelReference object
]

{ #category : #accessing }
QuLeTranscriptPageType >> subjectModelID [

	^ self subjectModelReference ifNotNil: [ :ref | ref uid ]
]

{ #category : #accessing }
QuLeTranscriptPageType >> subjectModelReference [

	^ subjectModelReference
]

{ #category : #accessing }
QuLeTranscriptPageType >> subjectModelReference: anMAObjectUIDReference [

	subjectModelReference := anMAObjectUIDReference
]

{ #category : #accessing }
QuLeTranscriptPageType >> title [

	^ self subjectModel 
		ifNotNil: [ : sub | sub transcript title ]
		ifNil: [ 'QuTranscript Page' ]
]
