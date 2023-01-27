Class {
	#name : #QuLeCitedSnippetViewModel,
	#superclass : #LeTextCoderSnippetViewModel,
	#category : #'QuoteMe-GToolkit-Citation-Lepiter'
}

{ #category : #accessing }
QuLeCitedSnippetViewModel >> snippetElementClass [
	^ QuLeCitedSnippetElement 
]

{ #category : #accessing }
QuLeCitedSnippetViewModel >> snippetView [

	^ QuLeCitedSnippetView new snippetElementClass: self snippetElementClass
]

{ #category : #accessing }
QuLeCitedSnippetViewModel >> sourceDisplayText [
	self snippetModel source ifNil: [ ^ '' asRopedText ].
	^ self snippetModel source quLeSourceText.
]
