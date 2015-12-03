package org.dspace.app.webui.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.Item;
import org.dspace.content.MetadataField;
import org.dspace.content.service.ItemService;
import org.dspace.content.service.MetadataFieldService;
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
import it.cilea.core.spring.controller.Spring3CoreController;

@Controller
@RequestMapping("/item")
public class ItemFormController extends Spring3CoreController {

	@ModelAttribute("command")
	public Item formBacking(@RequestParam String itemId, HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		return itemService.findByIdOrLegacyId(context, itemId);
	}

	@RequestMapping(value = { "**/form", "/form" }, method = RequestMethod.GET)
	public ModelAndView processGet(@ModelAttribute("command") Item item, HttpServletRequest request) {
		// return new
		// ModelAndView(getControllerLogic(request.getServletPath()).getViewName(),
		// "command", item);
		return new ModelAndView("/item/form", "command", item);
	}

	@RequestMapping(value = { "**/form", "/form" }, method = RequestMethod.POST)
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
			if (metadataField == null)
				continue;
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

	@Autowired
	private ItemService itemService;
	@Autowired
	private MetadataFieldService metadataFieldService;

	public void setItemService(ItemService itemService) {
		this.itemService = itemService;
	}

	public void setMetadataFieldService(MetadataFieldService metadataFieldService) {
		this.metadataFieldService = metadataFieldService;
	}

}
