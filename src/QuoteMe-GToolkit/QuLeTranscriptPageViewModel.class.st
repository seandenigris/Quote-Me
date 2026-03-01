Class {
	#name : 'QuLeTranscriptPageViewModel',
	#superclass : 'LePageViewModel',
	#instVars : [
		'player'
	],
	#category : 'QuoteMe-GToolkit-Transcripts-Lepiter',
	#package : 'QuoteMe-GToolkit',
	#tag : 'Transcripts-Lepiter'
}

{ #category : 'accessing' }
QuLeTranscriptPageViewModel >> player [

	^ player ifNil: [ player := self pageModel type newPlayer ]
]
