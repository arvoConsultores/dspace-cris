package org.dspace.app.webui.controller;

import javax.servlet.http.HttpServletRequest;

import org.dspace.app.webui.util.UIUtil;
import org.dspace.content.Community;
import org.dspace.content.service.CommunityService;
import org.dspace.core.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/community")
public class CommunityController {

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

	@Autowired
	private CommunityService communityService;

	public void setCommunityService(CommunityService communityService) {
		this.communityService = communityService;
	}
}
