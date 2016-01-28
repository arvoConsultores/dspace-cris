package org.dspace.app.webui.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import it.cilea.core.spring.controller.Spring3CoreController;

@Controller
@RequestMapping("/language/")
public class ChangeLanguageController extends Spring3CoreController {

	@RequestMapping("change.ajax")
	protected void change(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.getWriter().println("<html>ok</html>");
	}
}
