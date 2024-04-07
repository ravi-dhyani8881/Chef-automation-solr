package com.spring.graph.utils;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public record QueryUtils() { 
		 public static String replaceTokens(String inputString, Map<String, Object> solrDocument) {
		        Pattern pattern = Pattern.compile("\\$\\{([^}]+)\\}");
		        Matcher matcher = pattern.matcher(inputString);
		        StringBuffer sb = new StringBuffer();
		        while (matcher.find()) {
		            String key = matcher.group(1);
		            Object value = solrDocument.get(key);
		            if (value != null) {
		                matcher.appendReplacement(sb, Matcher.quoteReplacement(value.toString()));
		            }
		        }
		        matcher.appendTail(sb);
		        return sb.toString();
		    }	 
}