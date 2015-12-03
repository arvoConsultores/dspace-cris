package org.dspace.app.webui.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.DSpaceObject;
import org.dspace.core.Context;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import it.cilea.core.spring.controller.Spring3CoreController;
import it.cilea.core.widget.model.Widget;

@Controller
@RequestMapping("/metadata")
public class MetadataController extends Spring3CoreController {

	@ModelAttribute("command")
	public Widget formBacking(@RequestParam String widgetClass, HttpServletRequest request) throws Exception {
		Widget widget = (Widget) Class.forName(widgetClass).newInstance();

		return widget;
	}

	@RequestMapping("/field/new")
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
		return new ModelAndView("metadata/field/new", "command", d);
	}

}
