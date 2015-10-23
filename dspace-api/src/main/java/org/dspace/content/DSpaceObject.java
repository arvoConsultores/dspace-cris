/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package org.dspace.content;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.dspace.authorize.ResourcePolicy;
import org.dspace.comparator.MetadataFieldPlaceMapComparator;
import org.dspace.handle.Handle;
import org.hibernate.annotations.GenericGenerator;

/**
 * Abstract base class for DSpace objects
 */
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "dspaceobject")
public abstract class DSpaceObject implements Serializable {
	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid2")
	@Column(name = "uuid", unique = true, nullable = false, insertable = true, updatable = false)
	protected java.util.UUID id;

	// accumulate information to add to "detail" element of content Event,
	// e.g. to document metadata fields touched, etc.
	@Transient
	private StringBuffer eventDetails = null;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "dSpaceObject", cascade = {
			CascadeType.PERSIST }, orphanRemoval = true)
	@OrderBy("metadataField, place")
	private List<MetadataValue> metadata = new ArrayList<>();

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "dso")
	private Handle handle;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "dSpaceObject", cascade = {
			CascadeType.PERSIST }, orphanRemoval = false)
	private List<ResourcePolicy> resourcePolicies = new ArrayList<>();

	/**
	 * True if anything else was changed since last update() (to drive event
	 * mechanism)
	 */
	@Transient
	private boolean modifiedMetadata = false;

	/** Flag set when data is modified, for events */
	@Transient
	private boolean modified = false;

	/**
	 * Reset the cache of event details.
	 */
	public void clearDetails() {
		eventDetails = null;
	}

	/**
	 * Add a string to the cache of event details. Automatically separates
	 * entries with a comma. Subclass can just start calling addDetails, since
	 * it creates the cache if it needs to.
	 * 
	 * @param d
	 *            detail string to add.
	 */
	protected void addDetails(String d) {
		if (eventDetails == null) {
			eventDetails = new StringBuffer(d);
		} else {
			eventDetails.append(", ").append(d);
		}
	}

	/**
	 * @return summary of event details, or null if there are none.
	 */
	public String getDetails() {
		return (eventDetails == null ? null : eventDetails.toString());
	}

	/**
	 * Get the type of this object, found in Constants
	 * 
	 * @return type of the object
	 */
	public abstract int getType();

	/**
	 * Get the internal ID (database primary key) of this object
	 * 
	 * @return internal ID of object
	 */
	public UUID getID() {
		return id;
	}

	public abstract String getName();

	/**
	 * Get the Handle of the object. This may return <code>null</code>
	 * 
	 * @return Handle of the object, or <code>null</code> if it doesn't have one
	 */
	public String getHandle() {
		return (handle != null ? handle.getHandle() : null);
	}

	public void setHandle(Handle handle) {
		this.handle = handle;
	}

	protected List<MetadataValue> getMetadata() {
		return metadata;
	}

	public void setMetadata(List<MetadataValue> metadata) {
		this.metadata = metadata;
	}

	protected void removeMetadata(MetadataValue metadataValue) {
		setMetadataModified();
		getMetadata().remove(metadataValue);
	}

	protected void removeMetadata(List<MetadataValue> metadataValues) {
		setMetadataModified();
		getMetadata().removeAll(metadataValues);
	}

	protected void addMetadata(MetadataValue metadataValue) {
		setMetadataModified();
		getMetadata().add(metadataValue);
		addDetails(metadataValue.getMetadataField().toString());
	}

	public List<ResourcePolicy> getResourcePolicies() {
		return resourcePolicies;
	}

	public boolean isMetadataModified() {
		return modifiedMetadata;
	}

	protected void setMetadataModified() {
		this.modifiedMetadata = true;
	}

	public boolean isModified() {
		return modified;
	}

	public void clearModified() {
		this.modified = false;
	}

	protected void setModified() {
		this.modified = true;
	}

	@Transient
	public Map<String, List<String>> getMetadataMap() {
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		for (MetadataValue metadataValue : this.getMetadata()) {
			if (!map.containsKey(metadataValue.getMetadataField().toString()))
				map.put(metadataValue.getMetadataField().toString(), new ArrayList<String>());
			map.get(metadataValue.getMetadataField().toString()).add(metadataValue.getValue());
		}
		return map;

	}

	@Transient
	Map<String, List<String>> metadataFieldMap = null;

	@Transient
	public Map<String, List<String>> getMetadataFieldMap() {
		if (metadataFieldMap != null)
			return metadataFieldMap;
		metadataFieldMap = new HashMap<String, List<String>>();
		for (MetadataValue metadataValue : this.getMetadata()) {
			if (!metadataFieldMap.containsKey(metadataValue.getMetadataField().toString()))
				metadataFieldMap.put(metadataValue.getMetadataField().toString(), new ArrayList<String>());
			metadataFieldMap.get(metadataValue.getMetadataField().toString()).add(metadataValue.getValue());
		}
		return metadataFieldMap;

	}

	@Transient
	Map<String, String> metadataFieldPlaceMap = null;

	@Transient
	public Map<String, String> getMetadataFieldPlaceMap() {
		if (metadataFieldPlaceMap != null)
			return metadataFieldPlaceMap;
		metadataFieldPlaceMap = new TreeMap<String, String>(new MetadataFieldPlaceMapComparator());
		for (MetadataValue metadataValue : this.getMetadata()) {
			metadataFieldPlaceMap.put(metadataValue.getMetadataField().toString() + "_" + metadataValue.getPlace(),
					metadataValue.getValue());
		}
		return metadataFieldPlaceMap;

	}

	public void setMetadataFieldPlaceMap(Map<String, String> metadataFieldPlaceMap) {
		this.metadataFieldPlaceMap = metadataFieldPlaceMap;
	}

	// @Transient
	// Map<String, Map<String, String>> metadataFieldPlaceMap = null;
	//
	// @Transient
	// public Map<String, Map<String, String>> getMetadataFieldPlaceMap() {
	// if (metadataFieldPlaceMap != null)
	// return metadataFieldPlaceMap;
	// metadataFieldPlaceMap = new HashMap<String, Map<String, String>>();
	// for (MetadataValue metadataValue : this.getMetadata()) {
	// if
	// (!metadataFieldPlaceMap.containsKey(metadataValue.getMetadataField().toString()))
	// metadataFieldPlaceMap.put(metadataValue.getMetadataField().toString(),
	// new TreeMap<String, String>(new PlaceStringComparator()));
	// metadataFieldPlaceMap.get(metadataValue.getMetadataField().toString()).put("p"
	// + metadataValue.getPlace(),
	// metadataValue.getValue());
	// }
	// return metadataFieldPlaceMap;
	//
	// }
	//
	// public void setMetadataFieldPlaceMap(Map<String, Map<String, String>>
	// metadataFieldPlaceMap) {
	// this.metadataFieldPlaceMap = metadataFieldPlaceMap;
	// }
}