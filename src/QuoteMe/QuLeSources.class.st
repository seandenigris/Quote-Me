Class {
	#name : #QuLeSources,
	#superclass : #Object,
	#category : #'QuoteMe-GToolkit'
}

{ #category : #accessing }
QuLeSources >> children [
	^ { PpEventLog uniqueInstance. LlLibrary uniqueInstance }
]

{ #category : #accessing }
QuLeSources >> detectUuid: aString ifFound: foundBlock ifNone: noneBlock [

	{ PpEventLog uniqueInstance events. LlLibrary uniqueInstance works } do: [ :col |
		col 
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
	^ { PpEventLog uniqueInstance. LlLibrary uniqueInstance }
]
