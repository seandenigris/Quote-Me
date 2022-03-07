Class {
	#name : #QuQuoteLevel,
	#superclass : #Object,
	#category : #'QuoteMe-Core'
}

{ #category : #accessing }
QuQuoteLevel class >> all [
	^ self allSubclasses sort: #priority ascending
]

{ #category : #accessing }
QuQuoteLevel class >> initial [
	^ self name third
]
