Class {
	#name : #QuPage,
	#superclass : #Object,
	#instVars : [
		'page'
	],
	#category : #'QuoteMe-Core'
}

{ #category : #accessing }
QuPage class >> example [
	<gtExample>
	
	| citation |
	citation := QuPageCitation new
		source: LlAuthoredWork exampleAntifragile;
		page: 18;
		yourself.
	citation parenthetical should equal: '(Taleb, p. 18)'.
	^ citation
	
]

{ #category : #'instance creation' }
QuPage class >> number: aNumber [
	^ self new
		page: aNumber;
		yourself
]

{ #category : #magritte }
QuPage >> descriptionPage [
	<magritteDescription>
	
	^ MANumberDescription new
		accessor: #page;
		label: 'Page';
		priority: 200;
		yourself
]

{ #category : #accessing }
QuPage >> page [
	^ page
]

{ #category : #accessing }
QuPage >> page: anObject [
	page := anObject
]

{ #category : #accessing }
QuPage >> parenthetical [
	"'Parenthetical referencing, also known as Harvard referencing, has full or partial, in-text, citations enclosed in circular brackets and embedded in the paragraph.' - https://en.wikipedia.org/wiki/Citation"
	^ String streamContents: [ :s |
		s << '(' << self source author name lastName << ', p. ' << self page asString << ')' ]
]

{ #category : #printing }
QuPage >> printOn: aStream [

	aStream nextPutAll: 'p. '.
	page ifNotNil: [ aStream print: page ].
]
