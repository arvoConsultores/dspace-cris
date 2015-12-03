package org.dspace.app.webui.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.authorize.AuthorizeException;
import org.dspace.authorize.service.AuthorizeService;
import org.dspace.content.Collection;
import org.dspace.content.Community;
import org.dspace.content.service.CommunityService;
import org.dspace.core.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import it.cilea.core.spring.controller.Spring3CoreController;

@Controller
@RequestMapping("/community")
public class CommunityController extends Spring3CoreController {

	@RequestMapping("/get")
	public ModelAndView get(@RequestParam String communityId, HttpServletRequest request) throws Exception {
		return modelAndViewGet(communityId, communityService, request);
	}

	protected static ModelAndView modelAndViewGet(String communityId, CommunityService communityService,
			HttpServletRequest request) throws Exception {
		Context context = UIUtil.obtainContext(request);
		Community community = communityService.findByIdOrLegacyId(context, communityId);
		return new ModelAndView("community/get", "command", community);
	}

	@RequestMapping("/browse")
	public ModelAndView browse(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, AuthorizeException {
		// This will map community IDs to arrays of collections
		Map<String, List<Collection>> colMap;

		// This will map communityIDs to arrays of sub-communities
		Map<String, List<Community>> commMap;

		colMap = new HashMap<String, List<Collection>>();
		commMap = new HashMap<String, List<Community>>();
		Context context = UIUtil.obtainContext(request);
		List<Community> communities = communityService.findAllTop(context);

		for (Community c : communities) {
			build(c, colMap, commMap);
		}

		// can they admin communities?
		if (authorizeService.isAdmin(context)) {
			// set a variable to create an edit button
			request.setAttribute("admin_button", Boolean.TRUE);
		}

		request.setAttribute("communities", communities);
		request.setAttribute("collections.map", colMap);
		request.setAttribute("subcommunities.map", commMap);
		return new ModelAndView("/community/browse");
	}

	private void build(Community c, Map<String, List<Collection>> colMap, Map<String, List<Community>> commMap)
			throws SQLException {

		String comID = c.getID().toString();

		// Find collections in community
		List<Collection> colls = c.getCollections();
		colMap.put(comID, colls);

		// Find subcommunties in community
		List<Community> comms = c.getSubcommunities();

		// Get all subcommunities for each communities if they have some
		if (comms.size() > 0) {
			commMap.put(comID, comms);

			for (Community sub : comms) {

				build(sub, colMap, commMap);
			}
		}
	}

	@Autowired
	private CommunityService communityService;
	@Autowired
	private AuthorizeService authorizeService;

	public void setCommunityService(CommunityService communityService) {
		this.communityService = communityService;
	}

	public void setAuthorizeService(AuthorizeService authorizeService) {
		this.authorizeService = authorizeService;
	}
}
