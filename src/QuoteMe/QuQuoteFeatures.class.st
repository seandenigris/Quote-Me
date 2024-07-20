Class {
	#name : #QuQuoteFeatures,
	#superclass : #TestCase,
	#category : #'QuoteMe-Features'
}

{ #category : #tests }
QuQuoteFeatures >> testCreateQuoteFromUrl [

	| quote content source |
	self skip.
	self flag: 'This would be great to simplify scripting, but I don''t currently plan on using it outside the UI, so it''s on hold'.
	content := '[Hydrarams] are working well on most doors but blowing seals on the more difficult ones'.
	source := 'https://www.facebook.com/TruckieTalk/photos/a.334513043285693.68970.310813728988958/399560306780966/' asUrl.

	quote := QuQuote new
		content: content;
		citation: source.
		
	quote citation source should equal: source.
	quote content should equal: content.
]

{ #category : #tests }
QuQuoteFeatures >> testSecondaryCitation [

	| url citation secondaryCitation primarySource |
	url := 'https://en.wikiquote.org/wiki/Richard_Feynman' asUrl.
	secondaryCitation := QuWebCitation new
		source: url;
		yourself.
	primarySource := 'Richard Feynman'.
	citation := QuSecondaryCitation new
		source: secondaryCitation;
		primarySource: primarySource;
		yourself.
	citation source should equal: secondaryCitation.
	citation primarySource should equal: primarySource.
]

{ #category : #tests }
QuQuoteFeatures >> testWebCitation [

	| url citation |
	url := 'https://en.wikipedia.org/wiki/Citation#Content' asUrl.
	citation := QuWebCitation new
		source: url;
		yourself.
	citation source should equal: url.
	(DateAndTime now - citation timestamp) should beLessThan: 1 second
]

{ #category : #tests }
QuQuoteFeatures >> testXxxCreateQuoteWithAuthorAndContent [

	| quote |
	self skip.
	self flag: 'This would be great to simplify scripting, but I don''t currently plan on using it outside the UI, so it''s on hold'.
	quote := QuQuote that: 'Nassim Taleb' said: 'Knowledge is reached (mostly) by removing junk from people''s heads.'.
	quote authorName should equal: 'Nassim Taleb'.
	quote content should equal: 'Knowledge is reached by removing junk from people''s heads.'.
]
