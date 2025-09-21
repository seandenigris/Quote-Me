Extension { #name : #LeTextSnippet }

{ #category : #'*QuoteMe-GToolkit' }
LeTextSnippet >> citeLinesOnPage: aPage [

	| lines |
	lines := self withAllChildrenBreadthFirst select: [ :chld | chld isKindOf: QuLeTranscriptLineSnippet ].
	lines allButFirst do: [ :line | 
		| citedSnippet |
		citedSnippet := QuLeCitedTextSnippet empty
			source: line;
			yourself.
		aPage addSnippet: citedSnippet ].
]
