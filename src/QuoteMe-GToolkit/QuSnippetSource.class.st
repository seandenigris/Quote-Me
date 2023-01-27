Class {
	#name : #QuSnippetSource,
	#superclass : #Object,
	#category : #'QuoteMe-GToolkit'
}

{ #category : #accessing }
QuSnippetSource >> detectUID: anLeUID ifNone: noneBlock [

	^ [ | logicalDB |
		logicalDB := LeDatabasesRegistry uniqueInstance defaultLogicalDatabase.
		logicalDB blockWithUID: anLeUID 
	]
		on: KeyNotFound do: noneBlock
]

{ #category : #accessing }
QuSnippetSource >> source [

	^ self
]
