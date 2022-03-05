package com.aquapaka.donationwebapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.service.DonationEventService;
import com.aquapaka.donationwebapp.service.DonationService;
import com.aquapaka.donationwebapp.service.FilterService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {

    @Autowired
    private DonationEventService donationEventService;

    @Autowired
    private AppUserService appUserService;

    @Autowired
    private DonationService donationService;

    @Autowired
    private FilterService filterService;
    
    @GetMapping("/")
    public String index(Model model, HttpServletRequest request) {
        // Get donation events data
        List<DonationEvent> donationEvents = donationEventService.getDonationEvents();
        model.addAttribute("donationEvents", donationEvents);

        return filterService.filterGuest(request, model, "index");
    }

    @GetMapping("userManagement/{page}")
    public String userManagement(Model model, HttpServletRequest request, @PathVariable int page) {

        // Get appUser datas
        Page<AppUser> appUserPage = appUserService.getAppUsers(page);
        List<AppUser> appUsers = appUserPage.getContent();
        int totalPage = appUserPage.getTotalPages();
        model.addAttribute("appUsers", appUsers);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);

        return filterService.filterAdmin(request, model, "userManagement");
    }

    @GetMapping("userManagement/search/{page}")
    public String userManagement (
    Model model, 
    HttpServletRequest request,
    @PathVariable int page,
    @RequestParam String searchText,
    @RequestParam String searchType,
    @RequestParam String sortType) {

        // Get appUser datas
        Page<AppUser> appUserPage = appUserService.searchAppUsers(searchText, searchType, sortType, page);
        List<AppUser> appUsers = appUserPage.getContent();
        int totalPage = appUserPage.getTotalPages();
        
        model.addAttribute("appUsers", appUsers);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);

        return filterService.filterAdmin(request, model, "userManagement");
    }
    
    @GetMapping("donationEventManagement/{page}")
    public String donationEventManagement(Model model, HttpServletRequest request,
    @RequestParam(value = "searchText", required = false, defaultValue = "") String searchText,
    @RequestParam(value = "searchType", required = false, defaultValue = "") String searchType,
    @PathVariable int page) {

        // Get donation event datas
        List<DonationEvent> donationEvents;
        if(searchText.trim().isEmpty()) {
            donationEvents = donationEventService.getDonationEvents();
        } else {
            donationEvents = donationEventService.getDonationEventsSearchBy(searchText, searchType);
        }
        
        model.addAttribute("donationEvents", donationEvents);

        return filterService.filterAdmin(request, model, "donationEventManagement");
    }
    
    @GetMapping("donationManagement")
    public String donationManagement(Model model, HttpServletRequest request) {

        // Get donation datas
        List<Donation> donations = donationService.getDonations();
        model.addAttribute("donations", donations);

        return filterService.filterAdmin(request, model, "donationManagement");
    }
    
    @GetMapping("profile")
    public String userProfile(Model model, HttpServletRequest request) {
      
        return filterService.filterUser(request, model, "userProfile");
    }

}
