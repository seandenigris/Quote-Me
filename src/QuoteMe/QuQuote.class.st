"
Terminology:
- secondary source - e.g. I read Lt. McCormack who cites an internal FDNY memo; the reference is Lt. McCormack; the citation lists both e.g. Internal FDNY memo (as cited in McCormack, 2003) (http://www.apastyle.org/learn/faqs/cite-another-source.aspx)

| author |
author := MpPerson named: 'Aristotle'.
Quote that: author said: 'We are what we repeatedly do. Excellence, then is not an art, but a habit.'.

It seems like a quote has, not an author, but a source; like the source could be a person or a book by many people. We often use a shorthand.
"
Class {
	#name : #QuQuote,
	#superclass : #Object,
	#instVars : [
		'content',
		'citation'
	],
	#classInstVars : [
		'db'
	],
	#category : #'QuoteMe-Core'
}

{ #category : #'instance creation' }
QuQuote class >> db [

	^ db ifNil: [ db := OrderedCollection new ].
]

{ #category : #'instance creation' }
QuQuote class >> restoreFrom: aCollection [

	db := aCollection.
]

{ #category : #'instance creation' }
QuQuote class >> spData [

	^ db
]

{ #category : #'instance creation' }
QuQuote class >> that: person said: aString [

	| source citation |
	
	source := QuUnknownSource new 
		author: person; 
		yourself.
		
	citation := QuCitation new 
		source: source; 
		yourself.
		
	^ self new
		content: aString;
		citation: citation;
		yourself.
]

{ #category : #accessing }
QuQuote >> author: aPerson [
	self shouldBeImplemented.
	"self citation source author: aPerson
	
	It's not necessarily right to alter the source. What about multi-authored works?"
]

{ #category : #accessing }
QuQuote >> authorName [
	self authors size = 1 ifFalse: [ self error: 'multiple authors' ].
	^ self authors first fullName.
]

{ #category : #accessing }
QuQuote >> authors [
	^ citation authors.
]

{ #category : #accessing }
QuQuote >> citation [
	"'A citation is a reference to a... source' (http://en.wikipedia.org/wiki/Citation). We experimented with many other names for this message. #source didn't work because e.g. when a page number is required, that page number doesn't seem to be part of the 'source'. #reference seemed too generic, as it could mean either the source itself or a mention of it"

	^ citation
]

{ #category : #accessing }
QuQuote >> citation: anObject [
	citation := anObject
]

{ #category : #accessing }
QuQuote >> content [

	^ content.
]

{ #category : #accessing }
QuQuote >> content: anObject [
	content := anObject
]

{ #category : #magritte }
QuQuote >> descriptionCitation [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #citation;
		label: 'Citation';
		priority: 200;
		classes: (QuCitation allSubclasses add: QuUnknownSource; yourself); 
		yourself
]

{ #category : #magritte }
QuQuote >> descriptionContent [
	<magritteDescription>
	
	^ MAMemoDescription new
		accessor: #content;
		label: 'Content';
		priority: 100;
		yourself
]

{ #category : #printing }
QuQuote >> printOn: aStream [

	aStream
		nextPutAll: $" asString, content, $" asString";
		nextPutAll: ' - ', author fullName".
]
