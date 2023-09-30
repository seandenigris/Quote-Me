Class {
	#name : #QuTranscript,
	#superclass : #Object,
	#instVars : [
		'lines',
		'pageID',
		'model',
		'titleSource'
	],
	#category : #'QuoteMe-Transcripts'
}

{ #category : #accessing }
QuTranscript >> delete [
	self subjectModel transcript: nil.
	self subjectModel: nil.
	
	self pageID ifNil: [ ^ self ].
	self lepiterPage removeSelf
]

{ #category : #accessing }
QuTranscript >> gtLiveFor: aView [
	<gtView>

	self pageID ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Live' translated;
		priority: 25;
		object: [ self lepiterPage ];
		view: #gtLiveFor:;
		actionButtonIcon: LeIcons lepiterIcon
			tooltip: 'Lepiter Page (Inspect)'
			action: [ :aButton :aTab | aButton phlow spawnObject: self lepiterPage ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect Transcript'
			action: [ :aButton :aTab | aButton phlow spawnObject: self ];
		actionUpdateButton.
]

{ #category : #accessing }
QuTranscript >> gtViewLinesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Lines';
		priority: 35;
		items: [ self lines ]
]

{ #category : #accessing }
QuTranscript >> lines [

	^ lines ifNil: [ lines := SortedCollection sortUsing: #position ascending undefinedFirst ]
]

{ #category : #accessing }
QuTranscript >> lines: anObject [

	lines := anObject
]

{ #category : #accessing }
QuTranscript >> pageID [

	^ pageID
]

{ #category : #accessing }
QuTranscript >> pageID: anObject [

	pageID := anObject
]

{ #category : #accessing }
QuTranscript >> snippetsSearchOn: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'Snippets (Text)';
		items: [ self lepiterPage 
			ifNotNil: [ :page | page allChildrenTextSnippets ] 
			ifNil: [ #() ] ];
		itemName: #text;
		filterBySubstring
]

{ #category : #accessing }
QuTranscript >> subjectModel [
	^ model
]

{ #category : #accessing }
QuTranscript >> subjectModel: anObject [
	model := anObject
]

{ #category : #accessing }
QuTranscript >> title [
	^ self titleSource
		ifNil: [ self subjectModel displayString ]
		ifNotNil: [ :ts | ts title ]
]

{ #category : #accessing }
QuTranscript >> titleSource [
	"See setter comment"
	^ titleSource
]

{ #category : #accessing }
QuTranscript >> titleSource: anObject [
	"Title source handles the situation where a higher level object (i.e. one with more metainfo delegates transcripting to a lower level one. For example, an event recording work uses its copy's transcript as its own, but the title should be the work's title, which is more intention revealing"
	titleSource := anObject
]
