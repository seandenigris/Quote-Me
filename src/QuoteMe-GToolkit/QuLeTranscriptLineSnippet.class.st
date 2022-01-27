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
	result line speaker: page type model participants first.
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
	result line speaker: page type model participants first.
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
		priority: 2;
		object: [ self line ];
		view: #gtRawFor:
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> line [

	^ self model transcript lines
		detect: [ :e | e contentSnippetID = self uid ] 
		ifNone: [ nil ]
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> model [
	^ self page type model
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> parent: anObject [
	| newLine |
	anObject ifNil: [ 
		"Removed snippet from page"
		Halt now.
		self transcriptable transcript lines remove: self line.
		^ self ].

	super parent: anObject.
	
	self line ifNotNil: [ ^ self ].
	
	newLine := QuTranscriptLine new
		contentSnippetID: self uid;
		position: self page type player currentPosition;
		yourself.
	self transcriptable participants size = 1 ifTrue: [ newLine speaker: self transcriptable participants first ].
	self transcriptable transcript lines add: newLine.
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> speaker: aPerson [
	self line speaker: aPerson
]
