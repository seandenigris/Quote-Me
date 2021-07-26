Class {
	#name : #QuoteMeDB,
	#superclass : #SpFileDatabase,
	#category : 'QuoteMe-Persistence'
}

{ #category : #accessing }
QuoteMeDB class >> backupDirectoryParent [
	^ FileLocator dynabookData
]

{ #category : #'override in subclasses' }
QuoteMeDB class >> schema [

	^ { QuQuote. LivingLibraryDB }
]
