package it.cineca.surplus.ir.context;

import org.dspace.content.service.CollectionService;
import org.dspace.content.service.CommunityService;
import org.dspace.content.service.ItemService;
import org.dspace.content.service.MetadataFieldService;
import org.dspace.content.service.WorkspaceItemService;
import org.dspace.handle.service.HandleService;
import org.dspace.utils.DSpace;

import it.cilea.core.authorization.service.AuthorizationService;
import it.cilea.core.configuration.service.ConfigurationService;
import it.cilea.core.i18n.conf.CileaMessageSource;
import it.cilea.core.i18n.conf.DatabaseReloadableMessageSource;
import it.cilea.core.i18n.conf.StaticMessageSource;
import it.cilea.core.i18n.service.I18nService;
import it.cilea.core.menu.service.TreeNodeService;
import it.cilea.core.search.service.SearchService;
import it.cilea.core.search.strategy.impl.hibernate.HibernateSearchStrategy;
import it.cilea.core.search.strategy.impl.sql.SqlSearchStrategy;
import it.cilea.core.search.util.SearchBuilderTemplate;
import it.cilea.core.service.JaxbService;
import it.cilea.core.spring.factory.ControllerLogicFactory;
import it.cilea.core.spring.util.MessageUtil;
import it.cilea.core.view.service.ViewService;
import it.cilea.core.widget.service.WidgetService;

public class Surplus {

	DSpace dspace = new DSpace();

	public ConfigurationService getSurplusConfigurationService() {
		return dspace.getServiceManager().getServiceByName("surplusConfigurationService", ConfigurationService.class);
	}

	public TreeNodeService getTreeNodeService() {
		return dspace.getServiceManager().getServiceByName("treeNodeService", TreeNodeService.class);
	}

	public WidgetService getWidgetService() {
		return dspace.getServiceManager().getServiceByName("widgetService", WidgetService.class);
	}

	public SearchService getSearchService() {
		return dspace.getServiceManager().getServiceByName("searchService", SearchService.class);
	}

	public JaxbService getJaxbService() {
		return dspace.getServiceManager().getServiceByName("jaxbService", JaxbService.class);
	}

	public MessageUtil getMessageUtil() {
		return dspace.getServiceManager().getServiceByName("messageUtil", MessageUtil.class);
	}

	public I18nService getI18nService() {
		return dspace.getServiceManager().getServiceByName("i18nService", I18nService.class);
	}

	public ViewService getViewService() {
		return dspace.getServiceManager().getServiceByName("viewService", ViewService.class);
	}

	public SqlSearchStrategy getSqlSearchStrategy() {
		return dspace.getServiceManager().getServiceByName("sqlSearchStrategy", SqlSearchStrategy.class);
	}

	public HibernateSearchStrategy getHibernateSearchStrategy() {
		return dspace.getServiceManager().getServiceByName("hibernateSearchStrategy", HibernateSearchStrategy.class);
	}

	public DatabaseReloadableMessageSource getDatabaseReloadableMessageSource() {
		return dspace.getServiceManager().getServiceByName("dynamicMessageSource",
				DatabaseReloadableMessageSource.class);
	}

	public StaticMessageSource getStaticMessageSource() {
		return dspace.getServiceManager().getServiceByName("staticMessageSource", StaticMessageSource.class);
	}

	public CileaMessageSource getMessageSource() {
		CileaMessageSource source = dspace.getServiceManager().getServiceByName("messageSource",
				CileaMessageSource.class);

		return source;
	}

	public ControllerLogicFactory getControllerLogicFactory() {
		ControllerLogicFactory controllerLogicFactory = dspace.getServiceManager()
				.getServiceByName("controllerLogicFactory", ControllerLogicFactory.class);
		return controllerLogicFactory;
	}

	public AuthorizationService getAuthorizationService() {
		AuthorizationService authorizationService = dspace.getServiceManager().getServiceByName("authorizationService",
				AuthorizationService.class);
		return authorizationService;
	}

	public SearchBuilderTemplate getSearchBuilderTemplate() {
		return dspace.getServiceManager().getServiceByName("searchBuilderTemplate", SearchBuilderTemplate.class);
	}

	public CollectionService getCollectionService() {
		return dspace.getServiceManager().getServiceByName("collectionService", CollectionService.class);
	}

	public WorkspaceItemService getWorkspaceItemService() {
		return dspace.getServiceManager().getServiceByName("workspaceItemService", WorkspaceItemService.class);
	}

	public CommunityService getCommunityService() {
		return dspace.getServiceManager().getServiceByName("communityService", CommunityService.class);
	}

	public HandleService getHandleService() {
		return dspace.getServiceManager().getServiceByName("handleService", HandleService.class);
	}

	public ItemService getItemService() {
		return dspace.getServiceManager().getServiceByName("itemService", ItemService.class);
	}

	public MetadataFieldService getMetadataFieldService() {
		return dspace.getServiceManager().getServiceByName("metadataFieldService", MetadataFieldService.class);
	}
}
