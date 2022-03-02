Class {
	#name : #QuLeTranscriptLineSnippet,
	#superclass : #LeTextSnippet,
	#instVars : [
		'cachedLine'
	],
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
	page := QuLeTranscriptPageType exampleEmptyPage.
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
	page := QuLeTranscriptPageType exampleEmptyPage.
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
QuLeTranscriptLineSnippet >> contentAsString [
	^ self line position quTranscriptPositionGtDisplayText asString, ' ', self line speaker fullName, ': ', self string
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

	| isRemoving |
	isRemoving := anObject isNil.
	
	isRemoving ifTrue: [ 
		"We must do this before nil-ing out parent because we access the transcript *via that parent*"
		cachedLine := self line.
		self transcriptable transcript lines remove: self line ].

	super parent: anObject.
	
	(isRemoving or: [ "isMaterializing" self page isNil ]) ifTrue: [ ^ self ].
	
	self transcriptable	
		ifNil: [ 
			self notify: 'Transcript subject not found'
			"We want this to be resumable because maybe e.g. the model just hasn't been loaded yet" ]
		ifNotNil: [
			"This is inside the guard because to get the line, we need a subject"
			self line ifNil: [ 
				"Brand new snippet"
				self initializeLine.
				^ self ] ].
		
	"Will also end up here during materialization when adding a top-level snippet to a page"
	cachedLine ifNotNil: [ 
		"Snippet re-added after being moved"
		self transcriptable transcript lines add: cachedLine.
		cachedLine := nil "We don't want to rely on the cache unless we absolutely have to because we don't have a contract with the transcript model" ].
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
