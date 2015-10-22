package org.dspace.app.webui.editor;

import java.beans.PropertyEditorSupport;

import org.apache.commons.lang3.StringUtils;
import org.dspace.content.MetadataField;
import org.dspace.content.service.MetadataFieldService;
import org.dspace.core.Context;

public class CustomMetadataFieldEditor extends PropertyEditorSupport {
	MetadataFieldService metadataFieldService;

	public CustomMetadataFieldEditor(MetadataFieldService metadataFieldService) {
		this.metadataFieldService = metadataFieldService;
	}

	public String getAsText() {
		if (getValue() == null)
			return "";
		MetadataField metadataField = (MetadataField) getValue();
		return metadataField.toString();
	}

	public void setAsText(String text) throws IllegalArgumentException {
		setValue(text);
	}

	public void setValue(Object value) {
		if (value == null)
			super.setValue(value);
		else if (value instanceof MetadataField) {
			MetadataField metadataField = (MetadataField) value;
			super.setValue(metadataField);
		} else if (value instanceof String) {
			String string = (String) value;
			if (StringUtils.isBlank(string))
				super.setValue(null);
			else {
				Context context = null;
				try {
					context = new Context();
					String[] ciao = StringUtils.split(string);
					MetadataField metadataField = metadataFieldService.findByElement(context, ciao[0], ciao[1],
							ciao.length > 2 ? ciao[3] : null);
					super.setValue(metadataField);
				} catch (Exception e) {
					e.printStackTrace();

				} finally {
					if (context != null && context.isValid())
						context.abort();
				}
			}
		} else {
			throw new IllegalArgumentException("Value cannot be converted to Map: " + value);
		}
	}

}
