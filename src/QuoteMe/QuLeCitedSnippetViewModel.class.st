Class {
	#name : #QuLeCitedSnippetViewModel,
	#superclass : #LeTextCoderSnippetViewModel,
	#category : #'QuoteMe-GToolkit'
}

{ #category : #accessing }
QuLeCitedSnippetViewModel >> snippetElementClass [
	^ QuLeCitedSnippetElement 
]

{ #category : #accessing }
QuLeCitedSnippetViewModel >> sourceDisplayText [
	self snippetModel source ifNil: [ ^ '' asRopedText ].
	^ self snippetModel source title asRopedText.
]
