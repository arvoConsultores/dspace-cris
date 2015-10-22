package org.dspace.app.webui.controller;

import javax.servlet.http.HttpServletRequest;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.Item;
import org.dspace.content.service.ItemService;
import org.dspace.core.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	private ItemService itemService;

	@RequestMapping("/show/itemId/{itemId}")
	public ModelAndView showItem(@RequestParam String itemId, HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		Item item = itemService.findByIdOrLegacyId(context, itemId);

		return new ModelAndView("showItem", "command", item);
	}
	
	@RequestMapping("/get")
	public ModelAndView getItem(@RequestParam String itemId, HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		Item item = itemService.findByIdOrLegacyId(context, itemId);
		return new ModelAndView("showItem", "command", item);
	}

	public void setItemService(ItemService itemService) {
		this.itemService = itemService;
	}
}
