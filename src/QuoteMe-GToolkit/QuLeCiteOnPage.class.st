Class {
	#name : 'QuLeCiteOnPage',
	#superclass : 'Object',
	#instVars : [
		'skipIfExists',
		'targetPage',
		'sourceSnippets',
		'isTopOfPage'
	],
	#category : 'QuoteMe-GToolkit',
	#package : 'QuoteMe-GToolkit'
}

{ #category : 'accessing' }
QuLeCiteOnPage >> addSnippetSelector [

	^ self isTopOfPage
		ifTrue: [ #addFirstSnippet: ]
		ifFalse: [ #addSnippet: ]
]

{ #category : 'as yet unclassified' }
QuLeCiteOnPage >> citationExists [

	^ self targetPage allChildrenBreadthFirst anySatisfy: [ :existingSnippet |
		(existingSnippet isKindOf: QuLeCitedTextSnippet) 
			and: [ existingSnippet source = self sourceSnippet ] ]
]

{ #category : 'as yet unclassified' }
QuLeCiteOnPage >> ensureCitationOf: aSnippet [

	
	| citedSnippet |
	
	(self skipIfExists and: [ aSnippet isCitedOnPage: self targetPage ]) ifTrue: [ ^ self ].
	
	citedSnippet := QuLeCitedTextSnippet empty
		source: aSnippet;
		yourself.
		
	self targetPage 
		perform: self addSnippetSelector 
		with: citedSnippet
]

{ #category : 'as yet unclassified' }
QuLeCiteOnPage >> execute [

	| snippetsToAdd |
	
	snippetsToAdd := self isTopOfPage
		ifTrue: [ self sourceSnippets reversed ]
		ifFalse: [ self sourceSnippets ].
		
	snippetsToAdd do: [ :aSnippet | 
		self ensureCitationOf: aSnippet ]
]

{ #category : 'accessing' }
QuLeCiteOnPage >> isTopOfPage [

	^ self maLazyInstVarUsing: self isTopOfPageDescription
]

{ #category : 'accessing' }
QuLeCiteOnPage >> isTopOfPage: aBoolean [

	isTopOfPage := aBoolean
]

{ #category : 'accessing' }
QuLeCiteOnPage >> isTopOfPageDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
		accessor: #isTopOfPage;
		default: false;
		yourself
]

{ #category : 'accessing' }
QuLeCiteOnPage >> lepiterDatabase [

	^ LeDatabasesRegistry defaultLogicalDatabase
]

{ #category : 'as yet unclassified' }
QuLeCiteOnPage >> magritteFormExecuting [

	| builder |
	builder := self magritteDescription elementBuilderFor: self.
	builder addButtons: #(execute).
	^ builder element
]

{ #category : 'as yet unclassified' }
QuLeCiteOnPage >> mementoClass [

	^ MAStraightMemento
]

{ #category : 'accessing' }
QuLeCiteOnPage >> skipIfExists [
	^ self maLazyInstVarUsing: self skipIfExistsDescription
]

{ #category : 'accessing' }
QuLeCiteOnPage >> skipIfExists: anObject [
	skipIfExists := anObject
]

{ #category : 'accessing' }
QuLeCiteOnPage >> skipIfExistsDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
		accessor: #skipIfExists;
		default: true;
		yourself
]

{ #category : 'accessing' }
QuLeCiteOnPage >> sourceSnippets [
	^ sourceSnippets ifNil: [ sourceSnippets := OrderedCollection new ]
]

{ #category : 'accessing' }
QuLeCiteOnPage >> sourceSnippets: anObject [
	sourceSnippets := anObject
]

{ #category : 'accessing' }
QuLeCiteOnPage >> sourceSnippetsAdd: aSnippet [
	^ self sourceSnippets add: aSnippet
]

{ #category : 'accessing' }
QuLeCiteOnPage >> targetPage [
	^ targetPage
]

{ #category : 'accessing' }
QuLeCiteOnPage >> targetPage: anObject [
	targetPage := anObject
]

{ #category : 'accessing' }
QuLeCiteOnPage >> targetPageDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #targetPage;
		classes: { LePage };
		gtSearchDelegateTo: self lepiterDatabase message: #gtSpotterContentFor:;
		yourself.
]
