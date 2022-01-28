"
The problem with creating an instance is that a particular model object may not know how to create a reference to itself. In fact, it probably doesn't. An Event, for example, might live in a log, but what log? And we can't hardcode the assumptions of the library about where events live because another library using the first may make different assumptions.

Thus, we provide a class-side map for libraries to configure how to construct a reference for a particular class. The configuration can be edited via {{gtMethod:QuLeTransciptPageType class>>#modelReferenceForClass:builder:}}
"
Class {
	#name : #QuLeTransciptPageType,
	#superclass : #LePageType,
	#instVars : [
		'modelReference',
		'player'
	],
	#classVars : [
		'ModelReferenceBuilder',
		'ModelReferenceBuilderMap'
	],
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

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

{ #category : #accessing }
QuLeTransciptPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#modelReference -> #modelReference);
		yourself
]

{ #category : #accessing }
QuLeTransciptPageType class >> leJsonV4Name [

	^ 'quTranscriptPage'
]

{ #category : #'instance creation' }
QuLeTransciptPageType class >> model: anObject page: aLePage [
	| referenceBuilder reference |
	referenceBuilder := self modelReferenceBuilderMap at: anObject class.
	reference := referenceBuilder value
		uid: anObject ensureUUID;
		yourself.
	^ QuLeTransciptPageType new
		modelReference: reference;
		page: aLePage;
		yourself.
]

{ #category : #accessing }
QuLeTransciptPageType class >> modelReferenceBuilderMap [

	^ ModelReferenceBuilderMap ifNil: [ ModelReferenceBuilderMap := Dictionary new ]
]

{ #category : #accessing }
QuLeTransciptPageType class >> modelReferenceBuilderMap: anObject [

	^ ModelReferenceBuilderMap := anObject
]

{ #category : #accessing }
QuLeTransciptPageType class >> modelReferenceForClass: aClass builder: aValuable [
	^ self modelReferenceBuilderMap at: aClass put: aValuable
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
QuLeTransciptPageType >> isQuTranscriptPageType [
	^ true
]

{ #category : #accessing }
QuLeTransciptPageType >> model [
	self modelReference ifNil: [ ^ nil ].
	^ self modelReference object
]

{ #category : #accessing }
QuLeTransciptPageType >> modelID [

	^ self modelReference ifNotNil: [ :ref | ref uid ]
]

{ #category : #accessing }
QuLeTransciptPageType >> modelReference [

	^ modelReference
]

{ #category : #accessing }
QuLeTransciptPageType >> modelReference: anMAObjectUIDReference [

	modelReference := anMAObjectUIDReference
]

{ #category : #accessing }
QuLeTransciptPageType >> peCustomizePageToolContentTreeElement: aLePageToolContentElement [
	"Sent from LePageToolContentTreeElement>>#onPageViewModelChanged"

	| playerWidget |
	
	self model isPlayable ifFalse: [ ^ super peCustomizePageToolContentTreeElement: aLePageToolContentElement ].
	
	aLePageToolContentElement headerElement 
		childNamed: #peHeader
		ifFound: [ :playerElement |
			playerElement player: self player.
			^ self ]
		ifNone: [
			playerWidget := LlMediaPlayerElement on: self player.
			aLePageToolContentElement headerElement addChild: playerWidget as: #peHeader ].
]

{ #category : #accessing }
QuLeTransciptPageType >> player [
	^ player ifNil: [ player := self model newPlayer ]
]

{ #category : #printing }
QuLeTransciptPageType >> printOn: aStream [

	aStream
		<< 'QuTranscript Page: ';
		<< (self model ifNotNil: #printString ifNil: [ '<none>' ])
]

{ #category : #accessing }
QuLeTransciptPageType >> resetPlayer [

	player := nil
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
		ifNil: [ 'QuTranscript Page' ]
]