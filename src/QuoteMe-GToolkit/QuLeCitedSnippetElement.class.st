Class {
	#name : 'QuLeCitedSnippetElement',
	#superclass : 'LeTextCoderSnippetElement',
	#instVars : [
		'snippetToolbar',
		'sourceText'
	],
	#category : 'QuoteMe-GToolkit-Citation-Lepiter',
	#package : 'QuoteMe-GToolkit',
	#tag : 'Citation-Lepiter'
}

{ #category : 'accessing' }
QuLeCitedSnippetElement >> initialize [

	| sourceLabel |
	super initialize.
	
	snippetToolbar := BrHorizontalPane new
		hMatchParent;
		padding: (BlInsets top: 4 bottom: 4);
		alignCenterLeft;
		cellSpacing: 5;
		vFitContent.
		
	sourceLabel := BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize;
		text: 'Source:'.
			
	sourceText := BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize;
		addEventHandlerOn: BlClickEvent
			do: [ :evt | 
				self snippetViewModel snippetModel source 
					ifNotNil: [ :src | evt target phlow spawnObject: src ] ];
		text: '';
		constraintsDo: [ :c |
			"This prevents the button from being pushed off the right edge"
			c horizontal matchParent ].
		
	snippetToolbar
		addChild: sourceLabel;
		addChild: sourceText;
		addChild: self newSearchButton
]

{ #category : 'accessing' }
QuLeCitedSnippetElement >> newSearchButton [
	^ GtSpotterDropdownButtonStencil new
		valuable: [ self snippetViewModel snippetModel ];
		icon: BrGlamorousVectorIcons search;
		actOn: [ :evt | 
			self snippetViewModel snippetModel source: evt objectToSend.
			self onSourceChanged.
			evt beActed ];
		create
]

{ #category : 'accessing' }
QuLeCitedSnippetElement >> onSnippetViewModelChanged [
	self onSourceChanged.
	super onSnippetViewModelChanged.
]

{ #category : 'accessing' }
QuLeCitedSnippetElement >> onSourceChanged [
	sourceText text: self snippetViewModel sourceDisplayText.
]

{ #category : 'accessing' }
QuLeCitedSnippetElement >> snippetToolbar [

	^ snippetToolbar
]
