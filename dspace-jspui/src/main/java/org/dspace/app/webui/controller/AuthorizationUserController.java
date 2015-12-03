package org.dspace.app.webui.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import it.cilea.core.spring.controller.Spring3CoreController;

@Controller
public class AuthorizationUserController extends Spring3CoreController {

	@RequestMapping("/login")
	public ModelAndView get(HttpServletRequest request) throws Exception {
		return new ModelAndView("/login");
	}

}
