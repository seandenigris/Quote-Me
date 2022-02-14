Class {
	#name : #QuLeTranscriptLineSnippet,
	#superclass : #LeTextSnippet,
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #accessing }
QuLeTranscriptLineSnippet class >> empty [
	"Needed because superclass returns a vanilla text snippet"
	^ self new
]

{ #category : #examples }
QuLeTranscriptLineSnippet class >> exampleDumbledore [
	<gtExample>
	
	| page result |
	page := QuLeTransciptPageType exampleEmptyPage.
	result := self empty.
	page addSnippet: result.
	result line speaker: page type subjectModel participants first.
	result text: 'To the well-organized mind, death is but the next great adventure.' asRopedText.
	^ result
]

{ #category : #examples }
QuLeTranscriptLineSnippet class >> exampleHarryPotter [
	<gtExample>
	
	| page result |
	page := QuLeTransciptPageType exampleEmptyPage.
	result := self empty.
	page addSnippet: result.
	result line speaker: page type subjectModel participants first.
	result text: 'I don''t want to be rude or anything, but—this isn''t a great time for me to have a house elf in my bedroom.' asRopedText.
	^ result
]

{ #category : #accessing }
QuLeTranscriptLineSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		"add: (#lineID -> #lineID);
		yourself "
]

{ #category : #accessing }
QuLeTranscriptLineSnippet class >> leJsonV4Name [

	^ 'quTranscriptLineSnippet'
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> asSnippetViewModel [
	^ QuLeTranscriptLineSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> gtViewLineFor: aView [
	<gtView>
	self line ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Line';
		priority: 0.5;
		object: [ self line ];
		view: #gtRawFor:
]

{ #category : #initialization }
QuLeTranscriptLineSnippet >> initializeLine [

	| newLine player |
	newLine := QuTranscriptLine new
		contentSnippetID: self uid;
		yourself.
		
	self transcriptable participants size = 1 ifTrue: [ 
		newLine speaker: self transcriptable participants first ].
	self transcriptable transcript lines add: newLine
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> line [

	^ self transcriptable transcript lines
		detect: [ :e | e contentSnippetID = self uid ] 
		ifNone: [ nil ]
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> parent: anObject [

	anObject ifNil: [ 
		"Removed snippet from page"
		self transcriptable transcript lines remove: self line.
		^ self ].
	super parent: anObject.
	self line ifNil: [ self initializeLine ].
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> play [
	^ self page type player currentPosition: self line position
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> speaker: aPerson [
	self line speaker: aPerson
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> transcriptable [
	^ self page type subjectModel
]
