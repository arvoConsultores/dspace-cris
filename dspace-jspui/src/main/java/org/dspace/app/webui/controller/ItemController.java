package org.dspace.app.webui.controller;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.Item;
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
	public ModelAndView get(@RequestParam String itemId, HttpServletRequest request) throws Exception {
		return modelAndViewGet(itemId, itemService, request);
	}

	protected static ModelAndView modelAndViewGet(String itemId, ItemService itemService, HttpServletRequest request)
			throws Exception {
		Context context = UIUtil.obtainContext(request);
		Item item = itemService.findByIdOrLegacyId(context, itemId);
		return new ModelAndView("item/get", "command", item);
	}

	@RequestMapping("/list")
	public ModelAndView get(HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		Iterator<Item> iterator = itemService.findAll(context);
		return new ModelAndView("/item/list", "iterator", iterator);
	}

	@Autowired
	private ItemService itemService;

	public void setItemService(ItemService itemService) {
		this.itemService = itemService;
	}

}
