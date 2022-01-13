Class {
	#name : #QuLeCitedSnippetAptitude,
	#superclass : #LeSnippetExpandableAptitude,
	#category : #'QuoteMe-GToolkit'
}

{ #category : #accessing }
QuLeCitedSnippetAptitude >> hideActions [
	super hideActions.
	toolbarContainer visibility: BlVisibility gone
]
