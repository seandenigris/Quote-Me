Class {
	#name : 'QuLeCitedSnippetAptitude',
	#superclass : 'LeSnippetExpandableAptitude',
	#category : 'QuoteMe-GToolkit-Citation-Lepiter',
	#package : 'QuoteMe-GToolkit',
	#tag : 'Citation-Lepiter'
}

{ #category : 'accessing' }
QuLeCitedSnippetAptitude >> hideActions [
	super hideActions.
	toolbarContainer visibility: BlVisibility gone
]
