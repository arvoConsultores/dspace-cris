package org.dspace.app.webui.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.dspace.app.webui.util.UIUtil;
import org.dspace.authenticate.service.AuthenticationService;
import org.dspace.content.Collection;
import org.dspace.content.Item;
import org.dspace.content.WorkspaceItem;
import org.dspace.content.service.CollectionService;
import org.dspace.content.service.WorkspaceItemService;
import org.dspace.core.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import it.cilea.core.spring.controller.Spring3CoreController;

@Controller
@RequestMapping("/item/new")
public class ItemNewFormController extends Spring3CoreController {

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView processGet(HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		List<Collection> collectionList = collectionService.findAll(context);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("collectionList", collectionList);
		return new ModelAndView("/item/new", model);
	}

	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView processPost(@ModelAttribute("command") Item item, BindingResult result,
			HttpServletRequest request) throws Exception {
		if (request.getParameter("cancel") != null)
			return new ModelAndView(getControllerLogic(request.getServletPath()).getViewUndo());

		if (result.hasErrors()) {
			return processGet(request);
		}
		return new ModelAndView("redirect:/item/form.htm", "itemId", item.getID().toString());
	}

	@ModelAttribute("command")
	public Item formBacking(@RequestParam(required = false) String collectionId, HttpServletRequest request)
			throws Exception {
		if (StringUtils.isBlank(collectionId))
			return null;
		Context context = UIUtil.obtainContext(request);
		Collection collection = collectionService.findByIdOrLegacyId(context, collectionId);
		context.ignoreAuthorization();
		WorkspaceItem wsi = workspaceItemService.create(context, collection, false);
		//authenticationService.authenticate(context, "r.suardi@cineca.it", "test", null, request);
		Item item = wsi.getItem();
		item.setArchived(true);
		item.setOwningCollection(collection);
		context.complete();
		return item;
	}

	@Autowired
	private CollectionService collectionService;
	@Autowired
	private WorkspaceItemService workspaceItemService;
	@Autowired
	private AuthenticationService authenticationService;

	public void setCollectionService(CollectionService collectionService) {
		this.collectionService = collectionService;
	}

	public void setWorkspaceItemService(WorkspaceItemService workspaceItemService) {
		this.workspaceItemService = workspaceItemService;
	}

	public void setAuthenticationService(AuthenticationService authenticationService) {
		this.authenticationService = authenticationService;
	}
}
