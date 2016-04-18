package com.smpro.util;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public class CommonServletUtil {
	public static HashMap<String,Object> getRequestParameterMap( HttpServletRequest request ) {
		HashMap<String,Object> requestParameterMap = new HashMap<>();
		java.util.Enumeration<String> pNames = request.getParameterNames();
		while( pNames.hasMoreElements() ) {
			String pName = pNames.nextElement();
			String[] pValues = request.getParameterValues( pName );
			
			if( pValues.length == 1 ) {
				requestParameterMap.put( pName, pValues[0].trim() );
			} else {
				for( int i=0; i<pValues.length; i++ ) {
					pValues[i] = pValues[i].trim();
				}
				requestParameterMap.put( pName, pValues );
			}
		}
		return requestParameterMap;
	}
}
