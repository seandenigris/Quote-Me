Class {
	#name : #LlMediaPlayerElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'player'
	],
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #'instance creation' }
LlMediaPlayerElement class >> on: aPlayer [

	^ self new
		player: aPlayer;
		yourself
]

{ #category : #accessing }
LlMediaPlayerElement >> currentTime [
	^ CwSafari new doJavascript: LlYouTubeVideo new jsPlayerGetCurrentTime
]

{ #category : #accessing }
LlMediaPlayerElement >> initialize [

	| button toolbar |
	super initialize.
	
	self fitContent.
	
	button := BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		label: 'Save';
		icon: BrGlamorousVectorIcons play;
		action: [ self player play ].
	
	self addChild: button
]

{ #category : #accessing }
LlMediaPlayerElement >> player [

	^ player
]

{ #category : #accessing }
LlMediaPlayerElement >> player: anObject [

	player := anObject
]
