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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/item")
public class ItemController {

	@RequestMapping("/show/itemId/{itemId}")
	public ModelAndView show(@PathVariable String itemId, HttpServletRequest request) throws Exception {
		return modelAndViewGet(itemId, itemService, request);
	}

	@RequestMapping("/get")
	public ModelAndView get(@RequestParam String itemId, HttpServletRequest request) throws Exception {
		return modelAndViewGet(itemId, itemService, request);
	}

	protected static ModelAndView modelAndViewGet(String itemId, ItemService itemService, HttpServletRequest request)
			throws Exception {
		Context context = UIUtil.obtainContext(request);
		Item item = itemService.findByIdOrLegacyId(context, itemId);
		return new ModelAndView("item/get", "command", item);
	}

	@RequestMapping("/new")
	public ModelAndView newItem(@RequestParam String collectionId, HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		Collection collection = collectionService.findByIdOrLegacyId(context, collectionId);
		WorkspaceItem wsi = workspaceItemService.create(context, collection, false);
		Item item = wsi.getItem();
		return new ModelAndView("redirect:/item/form.htm", "itemId", item.getID().toString());
	}

	@Autowired
	private ItemService itemService;
	@Autowired
	private CollectionService collectionService;
	@Autowired
	private WorkspaceItemService workspaceItemService;

	public void setItemService(ItemService itemService) {
		this.itemService = itemService;
	}

	public void setCollectionService(CollectionService collectionService) {
		this.collectionService = collectionService;
	}

	public void setWorkspaceItemService(WorkspaceItemService workspaceItemService) {
		this.workspaceItemService = workspaceItemService;
	}
}
