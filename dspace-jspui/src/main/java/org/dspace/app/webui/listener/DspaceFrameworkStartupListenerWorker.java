package org.dspace.app.webui.listener;

import javax.servlet.ServletContext;

import org.dspace.app.webui.controller.DspaceFrameworkController;
import org.springframework.context.ApplicationContext;

import it.cilea.core.listener.StartupListenerWorker;

public class DspaceFrameworkStartupListenerWorker implements StartupListenerWorker {

	@Override
	public void initialize(ServletContext servletContext, ApplicationContext applicationContext) throws Exception {
		DspaceFrameworkController.init(servletContext, applicationContext);
	}

	public Integer getPriority() {
		return 5;
	}
}