Class {
	#name : #QuLeTranscriptPageViewModel,
	#superclass : #LePageViewModel,
	#instVars : [
		'player'
	],
	#category : #'QuoteMe-GToolkit'
}

{ #category : #accessing }
QuLeTranscriptPageViewModel >> player [

	^ player ifNil: [ player := self pageModel type newPlayer ]
]
