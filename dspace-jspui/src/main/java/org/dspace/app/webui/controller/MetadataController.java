package org.dspace.app.webui.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.DSpaceObject;
import org.dspace.content.service.ItemService;
import org.dspace.core.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import it.cilea.core.widget.model.Widget;
import it.cilea.core.widget.service.WidgetService;

@Controller
@RequestMapping("/metadata")
public class MetadataController {

	@Autowired
	private WidgetService widgetService;
	@Autowired
	private ItemService itemService;

	@ModelAttribute("command")
	public Widget formBacking(@RequestParam String widgetClass, HttpServletRequest request) throws Exception {
		Widget widget = (Widget) Class.forName(widgetClass).newInstance();

		return widget;
	}

	@RequestMapping("/newField")
	public ModelAndView showItem(@Valid @ModelAttribute("command") Widget widget, BindingResult result,
			HttpServletRequest request) throws Exception {
		widget.init();
		request.setAttribute("widget", widget);
		Context context = UIUtil.obtainContext(request);
		DSpaceObject d = new DSpaceObject() {

			@Override
			public int getType() {
				// TODO Auto-generated method stub
				return 0;
			}

			@Override
			public String getName() {
				// TODO Auto-generated method stub
				return null;
			}
		};
		return new ModelAndView("metadata/newField", "command", d);
	}

	public void setWidgetService(WidgetService widgetService) {
		this.widgetService = widgetService;
	}

	public void setItemService(ItemService itemService) {
		this.itemService = itemService;
	}
}
