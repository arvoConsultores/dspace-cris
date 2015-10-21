package org.dspace.app.webui.controller;

import javax.servlet.http.HttpServletRequest;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.Collection;
import org.dspace.content.Item;
import org.dspace.content.WorkspaceItem;
import org.dspace.content.service.CollectionService;
import org.dspace.content.service.ItemService;
import org.dspace.content.service.WorkspaceItemService;
import org.dspace.core.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/item")
public class ItemFormController {

	@Autowired
	private CollectionService collectionService;
	@Autowired
	private WorkspaceItemService workspaceItemService;
	@Autowired
	private ItemService itemService;

	@RequestMapping("/new")
	public ModelAndView newItem(@RequestParam String collectionId, HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		Collection collection = collectionService.findByIdOrLegacyId(context, collectionId);
		WorkspaceItem wsi = workspaceItemService.create(context, collection, false);
		Item item = wsi.getItem();
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
