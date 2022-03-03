Class {
	#name : #BaselineOfQuoteMe,
	#superclass : #BaselineOf,
	#category : #BaselineOfQuoteMe
}

{ #category : #testing }
BaselineOfQuoteMe class >> isDynabook [
	^ true
]

{ #category : #baseline }
BaselineOfQuoteMe >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence' ].
		spec package: 'QuoteMe' with: [
				spec requires: #('Mocketry' 'PharoEnhancements' 'SimplePersistence'). ]. ].
				
	spec for: #GToolkit do: [ 
		spec 
			baseline: 'ObjectiveLepiter' with: [
				spec repository: 'github://seandenigris/Objective-Lepiter' ].
		spec package: 'QuoteMe-GToolkit' with: [ spec requires: #(QuoteMe #ObjectiveLepiter) ] ]
]

{ #category : #accessing }
BaselineOfQuoteMe >> customProjectAttributes [

	^ self isGTImage
			ifTrue: [ #(GToolkit) ]
			ifFalse: [ #(notGToolkit) ].
			
	"This is just for code generation purposes. To have an effect, it needs to be on the instance-side, but that could hide problems in other baselines because DeNigrisPreferences is not guaranteed to be loaded"
]

{ #category : #testing }
BaselineOfQuoteMe >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]
