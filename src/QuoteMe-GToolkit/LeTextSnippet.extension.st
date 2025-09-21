Extension { #name : #LeTextSnippet }

{ #category : #'*QuoteMe-GToolkit' }
LeTextSnippet >> citeLinesOnPage: aPage [
	"Create a cited snippet for each transcript line snippet including the receiver and all its descendents"

	| lines |
	lines := self withAllChildrenBreadthFirst select: [ :chld | chld isKindOf: QuLeTranscriptLineSnippet ].
	lines allButFirst do: [ :line | 
		| citedSnippet |
		citedSnippet := QuLeCitedTextSnippet empty
			source: line;
			yourself.
		aPage addSnippet: citedSnippet ].
]
