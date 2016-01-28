package org.dspace.app.webui.controller;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.Collection;
import org.dspace.content.Item;
import org.dspace.content.service.CollectionService;
import org.dspace.content.service.ItemService;
import org.dspace.core.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import it.cilea.core.spring.controller.Spring3CoreController;

@Controller
@RequestMapping("/item")
public class ItemController extends Spring3CoreController {

	@RequestMapping("/show/itemId/{itemId}")
	public ModelAndView show(@PathVariable String itemId, HttpServletRequest request) throws Exception {
		return modelAndViewGet(itemId, itemService, request);
	}

	@RequestMapping("/get")
	public ModelAndView getItem(@RequestParam String itemId, HttpServletRequest request) throws Exception {
		return modelAndViewGet(itemId, itemService, request);
	}

	protected static ModelAndView modelAndViewGet(String itemId, ItemService itemService, HttpServletRequest request)
			throws Exception {
		Context context = UIUtil.obtainContext(request);
		Item item = itemService.findByIdOrLegacyId(context, itemId);
		return new ModelAndView("item/get", "command", item);
	}

	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		Iterator<Item> iterator = itemService.findAll(context);
		return new ModelAndView("/item/list", "iterator", iterator);
	}

	@RequestMapping("/collection/list")
	public ModelAndView list(@RequestParam String collectionId, HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		Collection collection = collectionService.findByIdOrLegacyId(context, collectionId);
		Iterator<Item> iterator = itemService.findAllByCollection(context, collection);
		return new ModelAndView("/item/list", "iterator", iterator);
	}

	@Autowired
	private ItemService itemService;
	@Autowired
	private CollectionService collectionService;

	public void setItemService(ItemService itemService) {
		this.itemService = itemService;
	}

	public void setCollectionService(CollectionService collectionService) {
		this.collectionService = collectionService;
	}

}
