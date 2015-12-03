package org.dspace.app.webui.controller;

import java.util.Date;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import it.cilea.core.menu.model.TreeNode;
import it.cilea.core.menu.service.TreeNodeService;
import it.cilea.core.menu.utils.MenuUtil;
import it.cilea.core.spring.controller.Spring3CoreController;
import it.cilea.core.view.ViewConstant;
import it.cilea.core.view.model.ViewBuilder;
import it.cilea.core.view.model.ViewBuilderWidgetLink;
import it.cilea.core.view.service.ViewService;
import it.cilea.core.view.util.ViewUtil;
import it.cilea.core.widget.WidgetConstant;
import it.cilea.core.widget.model.Parameter;
import it.cilea.core.widget.model.WidgetDictionary;
import it.cilea.core.widget.model.impl.command.CommandSelect2Widget;
import it.cilea.core.widget.model.impl.command.CommandTextWidget;
import it.cilea.core.widget.model.impl.core.HtmlWidget;
import it.cilea.core.widget.service.WidgetService;

@Controller
public class DspaceFrameworkController extends Spring3CoreController {

	@RequestMapping("/dspace/framework/init")
	public ModelAndView get(HttpServletRequest request) throws Exception {
		// menuInit(request.getServletContext(), treeNodeService);
		viewBuilderInit(viewService, widgetService);
		saveMessage(request, messageUtil.findMessage("action.dspace.init"));
		return new ModelAndView("redirect:/?CLEAR");
	}

	public static void init(ServletContext servletContext, ApplicationContext applicationContext) throws Exception {
		TreeNodeService treeNodeService = (TreeNodeService) applicationContext.getBean("treeNodeService");
		menuInit(servletContext, treeNodeService);
		ViewService viewService = (ViewService) applicationContext.getBean("viewService");
		WidgetService widgetService = (WidgetService) applicationContext.getBean("widgetService");
		viewBuilderInit(viewService, widgetService);
	}

	private static void menuInit(ServletContext servletContext, TreeNodeService treeNodeService) throws Exception {
		Map<String, TreeNode> map = treeNodeService.getTreeNodeMap();
		if (!map.containsKey("/module.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/module.menu");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/top.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/top.menu");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/my.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/my.menu");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/module/browse.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/module/browse.menu");
			treeNode.setBrotherOrder(1);
			treeNode.setTreeParentNodeId(map.get("/module.menu").getId());
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/module/browse/community.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/module/browse/community.menu");
			treeNode.setBrotherOrder(1);
			treeNode.setTreeParentNodeId(map.get("/module/browse.menu").getId());
			treeNode.setLink("/${DSPACE_MODULE_NAME}/community/browse.htm?CLEAR");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/module/browse/collection.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/module/browse/collection.menu");
			treeNode.setBrotherOrder(2);
			treeNode.setTreeParentNodeId(map.get("/module/browse.menu").getId());
			treeNode.setLink("/${DSPACE_MODULE_NAME}/collection/browse.htm?CLEAR");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/module/item.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/module/item.menu");
			treeNode.setBrotherOrder(2);
			treeNode.setTreeParentNodeId(map.get("/module.menu").getId());
			treeNode.setLink("/${DSPACE_MODULE_NAME}/item/list.htm?CLEAR");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/top/item/new.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/top/item/new.menu");
			treeNode.setBrotherOrder(1);
			treeNode.setTreeParentNodeId(map.get("/top.menu").getId());
			treeNode.setLink("/${DSPACE_MODULE_NAME}/item/new.htm");
			treeNode.setVisibilityPath(".*/item/.*");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/top/community/new.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/top/community/new.menu");
			treeNode.setBrotherOrder(1);
			treeNode.setTreeParentNodeId(map.get("/top.menu").getId());
			treeNode.setLink("/${DSPACE_MODULE_NAME}/dspace-admin/edit-communities");
			treeNode.setVisibilityPath(".*/community/.*");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/module/configuration.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/module/configuration.menu");
			treeNode.setBrotherOrder(3);
			treeNode.setTreeParentNodeId(map.get("/module.menu").getId());
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/module/configuration/menu/reload.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/module/configuration/menu/reload.menu");
			treeNode.setBrotherOrder(1);
			treeNode.setTreeParentNodeId(map.get("/module/configuration.menu").getId());
			treeNode.setLink("/${DSPACE_MODULE_NAME}/menu/reload.htm?CLEAR");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/module/configuration/view/reload.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/module/configuration/view/reload.menu");
			treeNode.setBrotherOrder(2);
			treeNode.setTreeParentNodeId(map.get("/module/configuration.menu").getId());
			treeNode.setLink("/${DSPACE_MODULE_NAME}/view/reload.htm?CLEAR");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		if (!map.containsKey("/module/configuration/cms.menu")) {
			TreeNode treeNode = new TreeNode();
			treeNode.setIdentifier("/module/configuration/cms.menu");
			treeNode.setBrotherOrder(2);
			treeNode.setTreeParentNodeId(map.get("/module/configuration.menu").getId());
			treeNode.setLink("/${DSPACE_MODULE_NAME}/cms/elfinder.htm?CLEAR");
			treeNodeService.saveOrUpdate(treeNode);
			map.put(treeNode.getIdentifier(), treeNode);
		}
		MenuUtil.reload(servletContext, treeNodeService);
	}

	@Autowired
	private TreeNodeService treeNodeService;

	public void setTreeNodeService(TreeNodeService treeNodeService) {
		this.treeNodeService = treeNodeService;
	}

	private static void viewBuilderInit(ViewService viewService, WidgetService widgetService) throws Exception {
		ViewUtil.reload(viewService);
		Map<String, Set<ViewBuilder>> viewMap = ViewConstant.allViewBuilderMap;
		if (!viewMap.containsKey("/desktop")) {
			ViewBuilder viewBuilder = new ViewBuilder();
			viewBuilder.setIdentifier("/desktop");
			viewBuilder.setViewName("viewBuilder/nothing");
			viewBuilder.setManagedBy(ViewBuilder.ViewBuilderManagedBy.system.name());
			viewBuilder.setState(ViewBuilder.ViewBuilderState.active.name());
			viewBuilder.setVersionDate(new Date());
			viewBuilder.setVersionInfo("1.0");
			viewService.saveOrUpdate(viewBuilder);
			{
				HtmlWidget widget = new HtmlWidget();
				widget.setName("desktop_widget");
				widgetService.saveOrUpdate(widget);
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.EXPRESSION.name());
					parameter.setValue("Dspace home");
					widgetService.saveOrUpdate(parameter);
				}
				{
					ViewBuilderWidgetLink link = new ViewBuilderWidgetLink();
					link.setOrdering(1);
					link.setViewBuilderId(viewBuilder.getId());
					link.setWidgetId(widget.getId());
					viewService.saveOrUpdate(link);
				}
			}
		}

		if (!viewMap.containsKey("/item/get")) {
			ViewBuilder viewBuilder = new ViewBuilder();
			viewBuilder.setIdentifier("/item/get");
			viewBuilder.setViewName("viewBuilder/get");
			viewBuilder.setManagedBy(ViewBuilder.ViewBuilderManagedBy.system.name());
			viewBuilder.setState(ViewBuilder.ViewBuilderState.active.name());
			viewBuilder.setVersionDate(new Date());
			viewBuilder.setVersionInfo("1.0");
			viewService.saveOrUpdate(viewBuilder);
			{
				CommandTextWidget widget = new CommandTextWidget();
				widget.setName("get:command.metadataFieldPlaceMap[dc_title_1]");
				widget.setModelAttributeName("command.metadataFieldPlaceMap[dc_title_1]");
				widget.setPageAttributeName("command.metadataFieldPlaceMap[dc_title_1]");
				widgetService.saveOrUpdate(widget);
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.ALLOW_MULTIPLE.name());
					parameter.setValue("false");
					widgetService.saveOrUpdate(parameter);
				}
				{
					WidgetDictionary dictionary = new WidgetDictionary();
					dictionary.setWidgetId(widget.getId());
					dictionary.setWidget(widget);
					dictionary.setDiscriminator(WidgetConstant.WidgetDictionaryType.LABEL.name());
					dictionary.setI18nCustomIdentifier("label.title");
					widgetService.saveOrUpdate(dictionary);
				}
				{
					ViewBuilderWidgetLink link = new ViewBuilderWidgetLink();
					link.setOrdering(10);
					link.setViewBuilderId(viewBuilder.getId());
					link.setWidgetId(widget.getId());
					viewService.saveOrUpdate(link);
				}
			}
			{
				CommandSelect2Widget widget = new CommandSelect2Widget();
				widget.setName("get:command.metadataFieldPlaceMap[dc_format_medium_1]");
				widget.setModelAttributeName("command.metadataFieldPlaceMap[dc_format_medium_1]");
				widget.setPageAttributeName("command.metadataFieldPlaceMap[dc_format_medium_1]");
				widget.setPopulationType(WidgetConstant.OptionsWidgetPopulationType.JAVA_METHOD.name());
				widget.setPopulationValue("coreService|getSelectableListFromConcatenated");
				widgetService.saveOrUpdate(widget);
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.ALLOW_MULTIPLE.name());
					parameter.setValue("false");
					widgetService.saveOrUpdate(parameter);
				}
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.VALUE.name());
					parameter.setValue("cd,paper,dvd");
					widgetService.saveOrUpdate(parameter);
				}
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(2);
					parameter.setDiscriminator(WidgetConstant.ParameterType.VALUE.name());
					parameter.setValue("label.format.medium.");
					widgetService.saveOrUpdate(parameter);
				}
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.AUTO_DISPLAY.name());
					parameter.setValue("false");
					widgetService.saveOrUpdate(parameter);
				}
				{
					WidgetDictionary dictionary = new WidgetDictionary();
					dictionary.setWidgetId(widget.getId());
					dictionary.setWidget(widget);
					dictionary.setDiscriminator(WidgetConstant.WidgetDictionaryType.LABEL.name());
					dictionary.setI18nCustomIdentifier("label.format.medium");
					widgetService.saveOrUpdate(dictionary);
				}
				{
					ViewBuilderWidgetLink link = new ViewBuilderWidgetLink();
					link.setOrdering(15);
					link.setViewBuilderId(viewBuilder.getId());
					link.setWidgetId(widget.getId());
					viewService.saveOrUpdate(link);
				}
			}
			{
				CommandTextWidget widget = new CommandTextWidget();
				widget.setName("get:command.metadataFieldPlaceMap[dc_title_alternative_1]");
				widget.setModelAttributeName("command.metadataFieldPlaceMap[dc_title_alternative_1]");
				widget.setPageAttributeName("command.metadataFieldPlaceMap[dc_title_alternative_1]");
				widgetService.saveOrUpdate(widget);
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.ALLOW_MULTIPLE.name());
					parameter.setValue("false");
					widgetService.saveOrUpdate(parameter);
				}
				{
					WidgetDictionary dictionary = new WidgetDictionary();
					dictionary.setWidgetId(widget.getId());
					dictionary.setWidget(widget);
					dictionary.setDiscriminator(WidgetConstant.WidgetDictionaryType.LABEL.name());
					dictionary.setI18nCustomIdentifier("label.title_alternative");
					widgetService.saveOrUpdate(dictionary);
				}
				{
					ViewBuilderWidgetLink link = new ViewBuilderWidgetLink();
					link.setOrdering(20);
					link.setViewBuilderId(viewBuilder.getId());
					link.setWidgetId(widget.getId());
					viewService.saveOrUpdate(link);
				}
			}
			{
				CommandTextWidget widget = new CommandTextWidget();
				widget.setName("get:command.metadataFieldPlaceMap[dc_subject_classification]");
				widget.setModelAttributeName("command.metadataFieldPlaceMap[dc_subject_classification]");
				widget.setPageAttributeName("command.metadataFieldPlaceMap[dc_subject_classification]");
				widgetService.saveOrUpdate(widget);
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.ALLOW_MULTIPLE.name());
					parameter.setValue("true");
					widgetService.saveOrUpdate(parameter);
				}
				{
					WidgetDictionary dictionary = new WidgetDictionary();
					dictionary.setWidgetId(widget.getId());
					dictionary.setWidget(widget);
					dictionary.setDiscriminator(WidgetConstant.WidgetDictionaryType.LABEL.name());
					dictionary.setI18nCustomIdentifier("label.subject.classification");
					widgetService.saveOrUpdate(dictionary);
				}
				{
					ViewBuilderWidgetLink link = new ViewBuilderWidgetLink();
					link.setOrdering(30);
					link.setViewBuilderId(viewBuilder.getId());
					link.setWidgetId(widget.getId());
					viewService.saveOrUpdate(link);
				}
			}
		}

		if (!viewMap.containsKey("/item/form")) {
			ViewBuilder viewBuilder = new ViewBuilder();
			viewBuilder.setIdentifier("/item/form");
			viewBuilder.setViewName("viewBuilder/edit");
			viewBuilder.setManagedBy(ViewBuilder.ViewBuilderManagedBy.system.name());
			viewBuilder.setState(ViewBuilder.ViewBuilderState.active.name());
			viewBuilder.setVersionDate(new Date());
			viewBuilder.setVersionInfo("1.0");
			viewService.saveOrUpdate(viewBuilder);
			{
				CommandTextWidget widget = new CommandTextWidget();
				widget.setName("form:command.metadataFieldPlaceMap[dc_title_1]");
				widget.setModelAttributeName("command.metadataFieldPlaceMap[dc_title_1]");
				widget.setPageAttributeName("command.metadataFieldPlaceMap[dc_title_1]");
				widgetService.saveOrUpdate(widget);
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.ALLOW_MULTIPLE.name());
					parameter.setValue("false");
					widgetService.saveOrUpdate(parameter);
				}
				{
					WidgetDictionary dictionary = new WidgetDictionary();
					dictionary.setWidgetId(widget.getId());
					dictionary.setWidget(widget);
					dictionary.setDiscriminator(WidgetConstant.WidgetDictionaryType.LABEL.name());
					dictionary.setI18nCustomIdentifier("label.title");
					widgetService.saveOrUpdate(dictionary);
				}
				{
					ViewBuilderWidgetLink link = new ViewBuilderWidgetLink();
					link.setOrdering(10);
					link.setViewBuilderId(viewBuilder.getId());
					link.setWidgetId(widget.getId());
					viewService.saveOrUpdate(link);
				}
			}
			{
				CommandSelect2Widget widget = new CommandSelect2Widget();
				widget.setName("form:command.metadataFieldPlaceMap[dc_format_medium_1]");
				widget.setModelAttributeName("command.metadataFieldPlaceMap[dc_format_medium_1]");
				widget.setPageAttributeName("command.metadataFieldPlaceMap[dc_format_medium_1]");
				widget.setPopulationType(WidgetConstant.OptionsWidgetPopulationType.JAVA_METHOD.name());
				widget.setPopulationValue("coreService|getSelectableListFromConcatenated");
				widgetService.saveOrUpdate(widget);
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.ALLOW_MULTIPLE.name());
					parameter.setValue("false");
					widgetService.saveOrUpdate(parameter);
				}
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.VALUE.name());
					parameter.setValue("cd,paper,dvd");
					widgetService.saveOrUpdate(parameter);
				}
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(2);
					parameter.setDiscriminator(WidgetConstant.ParameterType.VALUE.name());
					parameter.setValue("label.format.medium.");
					widgetService.saveOrUpdate(parameter);
				}
				{
					WidgetDictionary dictionary = new WidgetDictionary();
					dictionary.setWidgetId(widget.getId());
					dictionary.setWidget(widget);
					dictionary.setDiscriminator(WidgetConstant.WidgetDictionaryType.LABEL.name());
					dictionary.setI18nCustomIdentifier("label.format.medium");
					widgetService.saveOrUpdate(dictionary);
				}
				{
					ViewBuilderWidgetLink link = new ViewBuilderWidgetLink();
					link.setOrdering(15);
					link.setViewBuilderId(viewBuilder.getId());
					link.setWidgetId(widget.getId());
					viewService.saveOrUpdate(link);
				}
			}
			{
				CommandTextWidget widget = new CommandTextWidget();
				widget.setName("form:command.metadataFieldPlaceMap[dc_title_alternative_1]");
				widget.setModelAttributeName("command.metadataFieldPlaceMap[dc_title_alternative_1]");
				widget.setPageAttributeName("command.metadataFieldPlaceMap[dc_title_alternative_1]");
				widgetService.saveOrUpdate(widget);
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.ALLOW_MULTIPLE.name());
					parameter.setValue("false");
					widgetService.saveOrUpdate(parameter);
				}
				{
					WidgetDictionary dictionary = new WidgetDictionary();
					dictionary.setWidgetId(widget.getId());
					dictionary.setWidget(widget);
					dictionary.setDiscriminator(WidgetConstant.WidgetDictionaryType.LABEL.name());
					dictionary.setI18nCustomIdentifier("label.title_alternative");
					widgetService.saveOrUpdate(dictionary);
				}
				{
					ViewBuilderWidgetLink link = new ViewBuilderWidgetLink();
					link.setOrdering(20);
					link.setViewBuilderId(viewBuilder.getId());
					link.setWidgetId(widget.getId());
					viewService.saveOrUpdate(link);
				}
			}
			{
				CommandTextWidget widget = new CommandTextWidget();
				widget.setName("form:command.metadataFieldPlaceMap[dc_subject_classification]");
				widget.setModelAttributeName("command.metadataFieldPlaceMap[dc_subject_classification]");
				widget.setPageAttributeName("command.metadataFieldPlaceMap[dc_subject_classification]");
				widgetService.saveOrUpdate(widget);
				{
					Parameter parameter = new Parameter();
					parameter.setWidgetId(widget.getId());
					parameter.setOrdering(1);
					parameter.setDiscriminator(WidgetConstant.ParameterType.ALLOW_MULTIPLE.name());
					parameter.setValue("true");
					widgetService.saveOrUpdate(parameter);
				}
				{
					WidgetDictionary dictionary = new WidgetDictionary();
					dictionary.setWidgetId(widget.getId());
					dictionary.setWidget(widget);
					dictionary.setDiscriminator(WidgetConstant.WidgetDictionaryType.LABEL.name());
					dictionary.setI18nCustomIdentifier("label.subject.classification");
					widgetService.saveOrUpdate(dictionary);
				}
				{
					ViewBuilderWidgetLink link = new ViewBuilderWidgetLink();
					link.setOrdering(30);
					link.setViewBuilderId(viewBuilder.getId());
					link.setWidgetId(widget.getId());
					viewService.saveOrUpdate(link);
				}
			}
		}

		ViewUtil.reload(viewService);
	}

	@Autowired
	private ViewService viewService;
	@Autowired
	private WidgetService widgetService;

	public void setViewService(ViewService viewService) {
		this.viewService = viewService;
	}

	public void setWidgetService(WidgetService widgetService) {
		this.widgetService = widgetService;
	}
}
