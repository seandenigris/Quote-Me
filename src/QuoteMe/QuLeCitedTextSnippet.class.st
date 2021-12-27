Class {
	#name : #QuLeCitedTextSnippet,
	#superclass : #LeTextSnippet,
	#instVars : [
		'sourceID'
	],
	#category : #'QuoteMe-GToolkit'
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
QuLeCitedTextSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ QuLeCitedSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
QuLeCitedTextSnippet >> contentAsString [
	^ super contentAsString
]

{ #category : #accessing }
QuLeCitedTextSnippet >> source [
	self sourceID ifNil: [ ^ nil ].
	
	^ LlLibrary uniqueInstance works detect: [ :e | e uuid = self sourceID ]
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
	^ GtSpotter on: LlLibrary uniqueInstance
]
