"
The problem with creating an instance is that a particular model object may not know how to create a reference to itself. In fact, it probably doesn't. An Event, for example, might live in a log, but what log? And we can't hardcode the assumptions of the library about where events live because another library using the first may make different assumptions.

Thus, we provide a class-side map for libraries to configure how to construct a reference for a particular class. The configuration can be edited via {{gtMethod:QuLeTransciptPageType class>>#modelReferenceForClass:builder:}}
"
Class {
	#name : #QuLeTranscriptPageType,
	#superclass : #OlObjectPageType,
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
	model stub olUID willReturn: 1.
	model stub uuid willReturn: 1.
	model stub participants willReturn: #('Jack' 'Jill').
	model stub transcript willReturn: transcript.
	self modelReferenceBuilderMap at: Object put: [OlDummyObjectUIDReferenceForTesting new
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

	self updatePrimaryDBPageTypes
]

{ #category : #accessing }
QuLeTranscriptPageType class >> leJsonV4Name [

	^ 'quTranscriptPage'
]

{ #category : #accessing }
QuLeTranscriptPageType >> asContentUIModel [
	^ QuLeTranscriptPageViewModel new pageModel: self page
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
QuLeTranscriptPageType >> title [

	^ self subjectModel 
		ifNotNil: [ : sub | sub transcript title ]
		ifNil: [ 'QuTranscript Page' ]
]
