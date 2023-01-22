Class {
	#name : #QuLeCitedSnippetElement,
	#superclass : #LeTextCoderSnippetElement,
	#instVars : [
		'snippetToolbar',
		'sourceLabel'
	],
	#category : #'QuoteMe-GToolkit-Citation-Lepiter'
}

{ #category : #accessing }
QuLeCitedSnippetElement >> initialize [

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
		addEventHandlerOn: BlClickEvent
			do: [ :evt | 
				self snippetViewModel snippetModel source 
					ifNotNil: [ :src | evt target phlow spawnObject: src ] ];
		text: ''.
		
	snippetToolbar
		addChild: (BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			beSmallSize;
			text: 'Source:');
		addChild: sourceLabel;
		addChild: self newSearchButton
]

{ #category : #accessing }
QuLeCitedSnippetElement >> newSearchButton [
	^ GtSpotterDropdownButtonStencil new
		valuable: [ self snippetViewModel snippetModel ];
		icon: BrGlamorousVectorIcons search;
		actOn: [ :evt | 
			self snippetViewModel snippetModel sourceID: evt objectToSend olUID.
			self onSourceChanged.
			evt beActed ];
		create
]

{ #category : #accessing }
QuLeCitedSnippetElement >> onSnippetViewModelChanged [
	self onSourceChanged.
	super onSnippetViewModelChanged.
]

{ #category : #accessing }
QuLeCitedSnippetElement >> onSourceChanged [
	sourceLabel text: self snippetViewModel sourceDisplayText.
]

{ #category : #accessing }
QuLeCitedSnippetElement >> snippetToolbar [

	^ snippetToolbar
]
