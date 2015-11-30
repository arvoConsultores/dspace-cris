package org.dspace.app.webui.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.Collection;
import org.dspace.content.Item;
import org.dspace.content.MetadataField;
import org.dspace.content.WorkspaceItem;
import org.dspace.content.service.CollectionService;
import org.dspace.content.service.ItemService;
import org.dspace.content.service.MetadataFieldService;
import org.dspace.content.service.WorkspaceItemService;
import org.dspace.core.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import it.cilea.core.dto.MultipleChoice;
import it.cilea.core.fragment.controller.Spring3CoreFormControllerFragmentEnabled;

@Controller
@RequestMapping("/item")
public class ItemFormController extends Spring3CoreFormControllerFragmentEnabled {

	@Autowired
	private CollectionService collectionService;
	@Autowired
	private WorkspaceItemService workspaceItemService;
	@Autowired
	private ItemService itemService;
	@Autowired
	private MetadataFieldService metadataFieldService;

	@RequestMapping("/new")
	public ModelAndView newItem(@RequestParam String collectionId, HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		Collection collection = collectionService.findByIdOrLegacyId(context, collectionId);
		WorkspaceItem wsi = workspaceItemService.create(context, collection, false);
		Item item = wsi.getItem();
		return new ModelAndView("showItem", "command", item);
	}

	@ModelAttribute("command")
	public Item formBacking(HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		if (StringUtils.isNotBlank(request.getParameter("itemId")))
			return itemService.findByIdOrLegacyId(context, request.getParameter("itemId"));
		Collection collection = collectionService.findByIdOrLegacyId(context, request.getParameter("collectionId"));
		WorkspaceItem wsi = workspaceItemService.create(context, collection, false);
		return wsi.getItem();
	}

	@RequestMapping(value = { "**/form", "/form", "**/new", "/new" }, method = RequestMethod.GET)
	public ModelAndView processGet(@ModelAttribute("command") Item item, HttpServletRequest request) {
		// return new
		// ModelAndView(getControllerLogic(request.getServletPath()).getViewName(),
		// "command", item);
		return new ModelAndView("/editItem", "command", item);
	}

	@RequestMapping(value = { "**/form", "/form", "**/new", "/new" }, method = RequestMethod.POST)
	public ModelAndView processPost(@Valid @ModelAttribute("command") Item item, BindingResult result,
			HttpServletRequest request) throws Exception {
		if (request.getParameter("cancel") != null)
			return new ModelAndView(getControllerLogic(request.getServletPath()).getViewUndo());

		executeXmlValidation(request, item, (Errors) result,
				getControllerLogic(request.getServletPath()).getValidatorList());

		if (result.hasErrors()) {
			genericReferenceDataNoCheckFormSubmission(item, result, request);
			return processGet(item, request);
		}
		Context context = UIUtil.obtainContext(request);
		// avrò l'elenco dei field presenti sulla pagina
		// accedo alla mappa per quei field

		Map<MetadataField, List<String>> finalMap = new HashMap<MetadataField, List<String>>();
		for (String fieldString : item.getMetadataFieldPlaceMap().keySet()) {
			String[] fieldArray = StringUtils.split(fieldString, "_");
			MetadataField metadataField = metadataFieldService.findByElement(context, fieldArray[0], fieldArray[1],
					fieldArray.length > 3 ? fieldArray[2] : null);
			if (!finalMap.containsKey(metadataField))
				finalMap.put(metadataField, new ArrayList<String>());
			if (StringUtils.isNotBlank(item.getMetadataFieldPlaceMap().get(fieldString)))
				finalMap.get(metadataField).add(item.getMetadataFieldPlaceMap().get(fieldString));
		}
		for (MetadataField metadataField : finalMap.keySet()) {
			itemService.clearMetadata(context, item, metadataField.getMetadataSchema().getName(),
					metadataField.getElement(), metadataField.getQualifier(), Item.ANY);
			if (finalMap.get(metadataField).size() > 0)
				itemService.addMetadata(context, item, metadataField, "it", finalMap.get(metadataField), null, null);
		}
		context.complete();
		saveMessage(request, messageUtil.findMessage("action.item.updated"));

		// gaService.saveOrUpdateWithFragment(item,
		// FragmentUtil.extractFragmentInfoMaps(request), gaService);

		// saveMessage(request, messageUtil.findMessage("action." + (firstInsert
		// ? "created" : "updated")));
		// return new
		// ModelAndView(getControllerLogic(request.getServletPath()).getViewSuccess(),
		// "itemId",
		// item.getID());
		return new ModelAndView("redirect:/item/form.htm", "itemId", item.getID().toString());
	}

	@ModelAttribute()
	public void genericReferenceData(@Valid Item item, BindingResult result, HttpServletRequest request)
			throws Exception {
		if (!isFormSubmission(request) && StringUtils
				.isNotBlank(getControllerLogic(request.getServletPath()).getMultipleChoiceListBeanName())) {
			List<MultipleChoice> list = (List<MultipleChoice>) context
					.getBean(getControllerLogic(request.getServletPath()).getMultipleChoiceListBeanName());
			super.genericReferenceData(item, request, list);
		}
	}

	public void genericReferenceDataNoCheckFormSubmission(@Valid Item item, BindingResult result,
			HttpServletRequest request) throws Exception {
		if (StringUtils.isNotBlank(getControllerLogic(request.getServletPath()).getMultipleChoiceListBeanName())) {
			List<MultipleChoice> list = (List<MultipleChoice>) context
					.getBean(getControllerLogic(request.getServletPath()).getMultipleChoiceListBeanName());
			super.genericReferenceData(item, request, list);
		}
	}

	public void setItemService(ItemService itemService) {
		this.itemService = itemService;
	}

	// @InitBinder
	// public void initBinder(WebDataBinder binder) {
	// DSpace dspace = context.getBean(DSpace.class);
	// MetadataFieldService metadataFieldService =
	// dspace.getSingletonService(MetadataFieldService.class);
	// binder.registerCustomEditor(MetadataField.class, new
	// CustomMetadataFieldEditor(metadataFieldService));
	// }
	public void setMetadataFieldService(MetadataFieldService metadataFieldService) {
		this.metadataFieldService = metadataFieldService;
	}
}
