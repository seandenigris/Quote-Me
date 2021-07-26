Class {
	#name : #QuPageCitation,
	#superclass : #QuCitation,
	#instVars : [
		'page'
	],
	#category : #'QuoteMe-Core'
}

{ #category : #'instance creation' }
QuPageCitation class >> citing: aWork page: aNumber [
	^ self new
		source: aWork;
		page: aNumber;
		yourself
]

{ #category : #accessing }
QuPageCitation class >> example [
	<gtExample>
	| book author citation |
	book := LlBook new
		author: MpPerson exampleNassimTaleb;
		yourself.
	citation := QuPageCitation new
		source: book;
		page: 18;
		yourself.
	citation parenthetical should equal: '(Taleb, p. 18)'.
	^ citation
	
]

{ #category : #magritte }
QuPageCitation >> descriptionPage [
	<magritteDescription>
	
	^ MANumberDescription new
		accessor: #page;
		label: 'Page';
		priority: 200;
		yourself
]

{ #category : #accessing }
QuPageCitation >> page [
	^ page
]

{ #category : #accessing }
QuPageCitation >> page: anObject [
	page := anObject
]

{ #category : #accessing }
QuPageCitation >> parenthetical [
	"'Parenthetical referencing, also known as Harvard referencing, has full or partial, in-text, citations enclosed in circular brackets and embedded in the paragraph.' - https://en.wikipedia.org/wiki/Citation"
	^ String streamContents: [ :s |
		s << '(' << self source author name lastName << ', p. ' << self page asString << ')' ]
]

{ #category : #printing }
QuPageCitation >> printOn: aStream [

	aStream nextPut: $(.
	source ifNotNil: [ aStream print: source ].
	page ifNotNil: [ 
		aStream
			space;
			print: page ].
	aStream nextPut: $).
]
