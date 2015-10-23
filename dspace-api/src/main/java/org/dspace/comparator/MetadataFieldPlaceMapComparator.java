package org.dspace.comparator;

import java.io.Serializable;
import java.util.Comparator;

import org.apache.commons.lang3.StringUtils;

public class MetadataFieldPlaceMapComparator implements Comparator<String>, Serializable {

	public int compare(String place1, String place2) {
		String field1 = StringUtils.substringBeforeLast(place1, "_");
		String field2 = StringUtils.substringBeforeLast(place2, "_");
		if (!field1.equals(field2))
			return field1.compareTo(field2);
		Integer place1Int = Integer.valueOf(StringUtils.substringAfterLast(place1, "_"));
		Integer place2Int = Integer.valueOf(StringUtils.substringAfterLast(place2, "_"));
		return place1Int.compareTo(place2Int);

	}
}
