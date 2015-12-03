package org.dspace.app.webui.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.authorize.AuthorizeException;
import org.dspace.content.Collection;
import org.dspace.content.service.CollectionService;
import org.dspace.core.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import it.cilea.core.spring.controller.Spring3CoreController;

@Controller
@RequestMapping("/collection")
public class CollectionController extends Spring3CoreController {

	@RequestMapping("/get")
	public ModelAndView get(@RequestParam String collectionId, HttpServletRequest request) throws Exception {
		return modelAndViewGet(collectionId, collectionService, request);
	}

	protected static ModelAndView modelAndViewGet(String collectionId, CollectionService collectionService,
			HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		Collection collection = collectionService.findByIdOrLegacyId(context, collectionId);
		return new ModelAndView("collection/get", "command", collection);
	}

	@RequestMapping("/browse")
	public ModelAndView browse(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, AuthorizeException, Exception {
		Context context = UIUtil.obtainContext(request);
		List<Collection> collections = collectionService.findAll(context);
		request.setAttribute("collections", collections);
		return new ModelAndView("/collection/browse");
	}

	@Autowired
	private CollectionService collectionService;

	public void setCollectionService(CollectionService collectionService) {
		this.collectionService = collectionService;
	}
}
