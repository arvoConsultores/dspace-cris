package org.dspace.app.webui.controller;

import javax.servlet.http.HttpServletRequest;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.Collection;
import org.dspace.content.Community;
import org.dspace.content.DSpaceObject;
import org.dspace.content.Item;
import org.dspace.content.service.CollectionService;
import org.dspace.content.service.CommunityService;
import org.dspace.content.service.ItemService;
import org.dspace.core.Context;
import org.dspace.handle.service.HandleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/handletmp")
public class HandleController {

	@RequestMapping("/get")
	public ModelAndView get(@RequestParam String handle, HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		DSpaceObject dSpaceObject = handleService.resolveToObject(context, handle);
		return modelAndViewGet(dSpaceObject, request);
	}

	@RequestMapping("/{prefix}/{handle}")
	public ModelAndView show(@PathVariable String prefix, @PathVariable String handle, HttpServletRequest request)
			throws Exception {
		Context context = UIUtil.obtainContext(request);
		DSpaceObject dSpaceObject = handleService.resolveToObject(context, prefix + "/" + handle);
		return modelAndViewGet(dSpaceObject, request);
	}

	private ModelAndView modelAndViewGet(DSpaceObject dSpaceObject, HttpServletRequest request) throws Exception {
		if (dSpaceObject instanceof Item)
			return ItemController.modelAndViewGet(dSpaceObject.getID().toString(), itemService, request);
		else if (dSpaceObject instanceof Community)
			return CommunityController.modelAndViewGet(dSpaceObject.getID().toString(), communityService, request);
		else if (dSpaceObject instanceof Collection)
			return CollectionController.modelAndViewGet(dSpaceObject.getID().toString(), collectionService, request);
		throw new Exception();
	}

	@Autowired
	private HandleService handleService;
	@Autowired
	private ItemService itemService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private CollectionService collectionService;

	public void setHandleService(HandleService handleService) {
		this.handleService = handleService;
	}

	public void setItemService(ItemService itemService) {
		this.itemService = itemService;
	}

	public void setCollectionService(CollectionService collectionService) {
		this.collectionService = collectionService;
	}

	public void setCommunityService(CommunityService communityService) {
		this.communityService = communityService;
	}
}
