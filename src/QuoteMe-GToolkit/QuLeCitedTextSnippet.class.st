Class {
	#name : #QuLeCitedTextSnippet,
	#superclass : #LeTextSnippet,
	#instVars : [
		'sourceID'
	],
	#category : #'QuoteMe-GToolkit-Citation-Lepiter'
}

{ #category : #accessing }
QuLeCitedTextSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'Cited Text'
]

{ #category : #'instance creation' }
QuLeCitedTextSnippet class >> empty [ 
	^ self new
]

{ #category : #accessing }
QuLeCitedTextSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: (#sourceID -> #sourceID);
		yourself 
]

{ #category : #accessing }
QuLeCitedTextSnippet class >> leJsonV4Name [

	^ 'quCitedTextSnippet'
]

{ #category : #accessing }
QuLeCitedTextSnippet >> addedToParent: aParent [
	super addedToParent: aParent.
	self
		previousSnippetDo: [ :prevSnip |
			(prevSnip isKindOf: QuLeCitedTextSnippet) ifFalse: [ ^ self  ].
			prevSnip source ifNotNil: [ :src | self sourceID: src uuid ] ]
		ifNone: []
]

{ #category : #accessing }
QuLeCitedTextSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ QuLeCitedSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
QuLeCitedTextSnippet >> detectSourceWithUID: aUid ifNone: noneBlock [

	^ self sourceProviders 
		detectUID: aUid 
		ifNone: noneBlock
]

{ #category : #accessing }
QuLeCitedTextSnippet >> gtSpotterSearchesInContext: aSpotterContext [
	
	^ self sourceProviders gtSpotterSearchesInContext: aSpotterContext
]

{ #category : #accessing }
QuLeCitedTextSnippet >> source [
	self sourceID ifNil: [ ^ nil ].
	
	^ self
		detectSourceWithUID: self sourceID 
		ifNone: [ nil ]
]

{ #category : #accessing }
QuLeCitedTextSnippet >> sourceID [
	^ sourceID
]

{ #category : #accessing }
QuLeCitedTextSnippet >> sourceID: aUID [ 
	sourceID := aUID
]

{ #category : #accessing }
QuLeCitedTextSnippet >> sourceProviders [

	^ QuLeSources new
]

{ #category : #accessing }
QuLeCitedTextSnippet >> sourceSpotter [
	^ GtSpotter on: self
]
