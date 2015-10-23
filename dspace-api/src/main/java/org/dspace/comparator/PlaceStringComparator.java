package org.dspace.comparator;

import java.io.Serializable;
import java.util.Comparator;

public class PlaceStringComparator implements Comparator<String>, Serializable {

	public int compare(String place1, String place2) {
		Integer place1Int = Integer.valueOf(place1.replace("p", ""));
		Integer place2Int = Integer.valueOf(place2.replace("p", ""));
		return place1Int.compareTo(place2Int);

	}
}
