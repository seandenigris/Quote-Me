Class {
	#name : #QuLeCitedTextSnippet,
	#superclass : #LeTextSnippet,
	#instVars : [
		'sourceID'
	],
	#classVars : [
		'SourceProviders'
	],
	#category : #'QuoteMe-GToolkit-Citation-Lepiter'
}

{ #category : #adding }
QuLeCitedTextSnippet class >> addSourceProvider: anObject getter: aSelector [

	| provider |
	provider := QuLeSourceProvider new
		model: anObject;
		sourceCollectionGetter: aSelector;
		yourself.
		
	^ self sourceProviders add: provider
]

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
QuLeCitedTextSnippet class >> sourceProviders [

	^ SourceProviders ifNil: [ SourceProviders := OrderedCollection new ]
]

{ #category : #accessing }
QuLeCitedTextSnippet class >> sourceProviders: anObject [

	^ SourceProviders := anObject
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
QuLeCitedTextSnippet >> detectSourceWithUuid: aString ifFound: foundBlock ifNone: noneBlock [

	self class sourceProviders do: [ :pro |
		pro sourceCollection
			detect: [ :e | e uuid = aString ] 
			ifFound: [ :e | ^ foundBlock cull: e ]
			ifNone: [ ] ].
		
	^ noneBlock value
]

{ #category : #accessing }
QuLeCitedTextSnippet >> gtSpotterProcessorsFor: aSpotterStep [
	
	^ self class sourceProviders flatCollect: [ :pro | pro modelGtSpotterProcessorsFor: aSpotterStep ]
]

{ #category : #accessing }
QuLeCitedTextSnippet >> source [
	self sourceID ifNil: [ ^ nil ].
	
	^ self
		detectSourceWithUuid: self sourceID 
		ifFound: #yourself
		ifNone: [ nil ]
]

{ #category : #accessing }
QuLeCitedTextSnippet >> sourceID [
	^ sourceID
]

{ #category : #accessing }
QuLeCitedTextSnippet >> sourceID: aString [ 
	sourceID := aString
]

{ #category : #accessing }
QuLeCitedTextSnippet >> sourceSpotter [
	^ GtSpotter on: self
]
