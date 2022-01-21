Class {
	#name : #QuLeSources,
	#superclass : #Object,
	#classVars : [
		'Providers'
	],
	#category : #'QuoteMe-GToolkit-Citation-Lepiter'
}

{ #category : #accessing }
QuLeSources class >> providers [

	^ Providers
]

{ #category : #accessing }
QuLeSources class >> providers: anObject [

	Providers := anObject
]

{ #category : #accessing }
QuLeSources >> children [
	^ self providers collect: #model
]

{ #category : #accessing }
QuLeSources >> detectUuid: aString ifFound: foundBlock ifNone: noneBlock [

	self providers do: [ :p |
		p sourceCollection 
			detect: [ :e | e uuid = aString ] 
			ifFound: [ :e | ^ foundBlock cull: e ]
			ifNone: [ ] ].
		
	^ noneBlock value
		
	
]

{ #category : #accessing }
QuLeSources >> gtSpotterProcessorsFor: aSpotterStep [
	^ self children flatCollect: [ :child | child gtSpotterProcessorsFor: aSpotterStep ]
]

{ #category : #accessing }
QuLeSources >> providers [
	^ self class providers
]
