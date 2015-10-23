package org.dspace.app.webui.controller;

import javax.servlet.http.HttpServletRequest;

import org.dspace.content.WorkspaceItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import it.cilea.core.widget.WidgetConstant;
import it.cilea.core.widget.model.Widget;
import it.cilea.core.widget.service.WidgetService;

@Controller
@RequestMapping("/metadata")
public class MetadataController {

	@Autowired
	private WidgetService widgetService;

	@RequestMapping("/newField")
	public ModelAndView showItem(@RequestParam Integer widgetId, HttpServletRequest request) throws Exception {
		Widget widget = WidgetConstant.widgetMap.get(widgetId);
		// Widget widget = widgetService.getWidget(widgetId);
		widget.setModelAttributeName("ciao");
		request.setAttribute("widget", widget);
		WorkspaceItem item = new WorkspaceItem();

		return new ModelAndView("metadata/newField", "command", item.getItem());
	}

	public void setWidgetService(WidgetService widgetService) {
		this.widgetService = widgetService;
	}
}
