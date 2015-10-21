package it.cineca.surplus.ir.context;

import org.dspace.utils.DSpace;

import it.cilea.core.authorization.service.AuthorizationService;
import it.cilea.core.authorization.service.OrcidHubService;
import it.cilea.core.authorization.service.OrcidHubWorkFlow;
import it.cilea.core.configuration.service.ConfigurationService;
import it.cilea.core.fragment.factory.FragmentControllerLogicFactory;
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

	public SqlSearchStrategy getSqlSearchStrategy() {
		return dspace.getServiceManager().getServiceByName("sqlSearchStrategy", SqlSearchStrategy.class);
	}

	public HibernateSearchStrategy getHibernateSearchStrategy() {
		return dspace.getServiceManager().getServiceByName("hibernateSearchStrategy", HibernateSearchStrategy.class);
	}

	public OrcidHubService getOrcidHubService() {
		OrcidHubService orcidHubService = dspace.getServiceManager().getServiceByName("orcidHubService",
				OrcidHubService.class);
		return orcidHubService;
	}

	public OrcidHubWorkFlow getOrcidHubWorkFlow() {
		OrcidHubWorkFlow orcidHubWorkFlow = dspace.getServiceManager().getServiceByName("orcidHubWorkFlow",
				OrcidHubWorkFlow.class);
		return orcidHubWorkFlow;
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

	public FragmentControllerLogicFactory getFragmentControllerLogicFactory() {
		FragmentControllerLogicFactory fragmentControllerLogicFactory = dspace.getServiceManager()
				.getServiceByName("fragmentControllerLogicFactory", FragmentControllerLogicFactory.class);
		return fragmentControllerLogicFactory;
	}

	public AuthorizationService getAuthorizationService() {
		AuthorizationService authorizationService = dspace.getServiceManager().getServiceByName("authorizationService",
				AuthorizationService.class);
		return authorizationService;
	}

	public SearchBuilderTemplate getSearchBuilderTemplate() {
		return dspace.getServiceManager().getServiceByName("searchBuilderTemplate", SearchBuilderTemplate.class);
	}
}
