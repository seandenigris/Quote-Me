Extension { #name : #LlAuthoredWork }

{ #category : #'*QuoteMe' }
LlAuthoredWork >> quote: aString onPage: aNumber [
	| citation quote |
	citation := QuPageCitation new
			source: self;
			page: aNumber;
			yourself.
	quote := QuQuote new
		content: aString;
		citation: citation;
		yourself.
	self quoteDb add: quote
]

{ #category : #'*QuoteMe' }
LlAuthoredWork >> quoteDb [
	^ QuQuote db
]

{ #category : #'*QuoteMe' }
LlAuthoredWork >> quotes [
	^ self quoteDb select: [ :e | e citation source = self ]
]
