package com.smpro.filter;

import java.io.File;
import java.io.FilenameFilter;

public class ImageFileNameFilter implements FilenameFilter {
	private String prefixFileName;
	
	public ImageFileNameFilter(String prefixFileName) {
		this.prefixFileName = prefixFileName;
	}
	
	@Override
	public boolean accept(File dir, String name) {
		if(dir.isDirectory()) {
			return name.startsWith(prefixFileName);
		}
		
		return false;
	}
}
