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
	^ String streamContents: [ :str |
		self position ifNotNil: [ :pos | str << pos quTranscriptPositionGtDisplayText asString << ' ' ].
		self speaker ifNotNil: [ :spkr | str << spkr fullName << ': ' ].
		str << self string ]
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

	| newLine |
	newLine := QuTranscriptLine new
		contentSnippetID: self uid;
		yourself.
	
	self transcriptable participants size = 1 
		ifTrue: [ 
			newLine speaker: self transcriptable participants first ]
		ifFalse: [
			self
				previousLineSnippetDo: [ :snip | newLine speaker: snip speaker ] 
				ifNone: [ ] ].
	self transcriptable transcript lines add: newLine
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> line [

	| subject |
	subject := self transcriptable ifNil: [ ^ nil ].
	^ subject transcript lines
		detect: [ :e | e contentSnippetID = self uid ] 
		ifNone: [ nil ]
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> parent: anObject [

	| isRemoving transcriptLines |
	isRemoving := anObject isNil.
	
	isRemoving ifTrue: [ 
		"We must do this before nil-ing out parent because we access the transcript *via that parent*"
		cachedLine := self line.
		transcriptLines := self transcriptable transcript lines.
		(transcriptLines identityIncludes: self line) ifTrue: [ transcriptLines remove: self line ] ].

	super parent: anObject.
	
	(isRemoving or: [ "isMaterializing" self page isNil ]) ifTrue: [ ^ self ].
	
	self transcriptable ifNil: [ 
		self notify: 'Transcript subject not found'.
		"We want this to be resumable because maybe e.g. the model just hasn't been loaded yet"
		
		^ self ].
			
	"Will also end up here during materialization when adding a top-level snippet to a page"
	cachedLine ifNotNil: [ 
		"Snippet re-added after being moved"
		self transcriptable transcript lines add: cachedLine.
		cachedLine := nil. "We don't want to rely on the cache unless we absolutely have to because we don't have a contract with the transcript model"
		^ self ].
		
	self line ifNil: [ 
		"Brand new snippet"
		self initializeLine.
		^ self ].
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> play [
	^ self page type player currentPosition: self line position
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> position [
	^ self line ifNotNil: #position
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> position: aDateAndTime [
	^ self line ifNotNil: [ :aLine | aLine position: aDateAndTime ]
]

{ #category : #initialization }
QuLeTranscriptLineSnippet >> previousLineSnippetDo: aBlock ifNone: noneBlock [

	| atEnd currentSnippet |
	atEnd := false.
	currentSnippet := self.
	
	[ currentSnippet 
		previousSnippetDo: [ :snip | 
			snip class = self class 
				ifTrue: [ ^ aBlock value: snip ]
				ifFalse: [ currentSnippet := snip ]  ]
		ifNone: [ atEnd := true ] ] doWhileFalse: [ atEnd ]
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> quLeSourceText [

	^ (self speaker fullName, ', ', self transcriptable quLeSourceText) asRopedText
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> speaker [
	^ self line ifNotNil: #speaker
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> speaker: aPerson [
	self line speaker: aPerson
]

{ #category : #accessing }
QuLeTranscriptLineSnippet >> transcriptable [
	^ self page type subjectModel
]
