enum PagingEnum {
  started,
  refreshed,
  paged,
  before,
}

/**
 * 				      = Started	refreshed	nextPaging	getOld
 * isRefreshed	= true		true		  false		    false
 * isNextPaging	= false		true		  true		    false
 * Enum			    = Started	Refreshed	Paged		    Before
 */
