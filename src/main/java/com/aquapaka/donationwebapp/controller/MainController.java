package com.aquapaka.donationwebapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.model.state.EventState;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.service.DonationEventService;
import com.aquapaka.donationwebapp.service.DonationService;
import com.aquapaka.donationwebapp.service.FilterService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
    public String index(
    Model model, 
    HttpServletRequest request,
    @RequestParam(required = false, defaultValue = "1") int page,
    @RequestParam(required = false, defaultValue = "") String searchText,
    @RequestParam(required = false, defaultValue = "title") String searchType,
    @RequestParam(required = false, defaultValue = "donationEventId") String sortType) {
        
        // Get appUser datas
        Page<DonationEvent> donationEventPage = donationEventService.searchDonationEvents(searchText, searchType, sortType, page, EventState.ACTIVE);
        List<DonationEvent> donationEvents = donationEventPage.getContent();
        int totalPage = donationEventPage.getTotalPages();
        
        model.addAttribute("donationEvents", donationEvents);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("searchText", searchText);
        model.addAttribute("searchType", searchType);
        model.addAttribute("sortType", sortType);

        return filterService.filterGuest(request, model, "index");
    }

    @GetMapping("/donation-events")
    public String donationEvents(
    Model model, 
    HttpServletRequest request,
    @RequestParam(required = false, defaultValue = "1") int page,
    @RequestParam(required = false, defaultValue = "") String searchText,
    @RequestParam(required = false, defaultValue = "title") String searchType,
    @RequestParam(required = false, defaultValue = "donationEventId") String sortType) {

        // Get appUser datas
        Page<DonationEvent> donationEventPage = donationEventService.searchDonationEvents(searchText, searchType, sortType, page, EventState.ACTIVE);
        List<DonationEvent> donationEvents = donationEventPage.getContent();
        int totalPage = donationEventPage.getTotalPages();
        
        model.addAttribute("donationEvents", donationEvents);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("searchText", searchText);
        model.addAttribute("searchType", searchType);
        model.addAttribute("sortType", sortType);

        return filterService.filterGuest(request, model, "donationEvents");
    }

    @GetMapping("user-management")
    public String userManagement(
    Model model, 
    HttpServletRequest request,
    @RequestParam(required = false, defaultValue = "1") int page,
    @RequestParam(required = false, defaultValue = "") String searchText,
    @RequestParam(required = false, defaultValue = "username") String searchType,
    @RequestParam(required = false, defaultValue = "appUserId") String sortType) {

        // Get appUser datas
        Page<AppUser> appUserPage = appUserService.searchAppUsers(searchText, searchType, sortType, page);
        List<AppUser> appUsers = appUserPage.getContent();
        int totalPage = appUserPage.getTotalPages();
        
        model.addAttribute("appUsers", appUsers);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("searchText", searchText);
        model.addAttribute("searchType", searchType);
        model.addAttribute("sortType", sortType);

        return filterService.filterAdmin(request, model, "userManagement");
    }
    
    @GetMapping("donation-event-management")
    public String donationEventManagement(
    Model model, 
    HttpServletRequest request,
    @RequestParam(required = false, defaultValue = "1") int page,
    @RequestParam(required = false, defaultValue = "") String searchText,
    @RequestParam(required = false, defaultValue = "title") String searchType,
    @RequestParam(required = false, defaultValue = "donationEventId") String sortType) {

        // Get appUser datas
        Page<DonationEvent> donationEventPage = donationEventService.searchDonationEvents(searchText, searchType, sortType, page);
        List<DonationEvent> donationEvents = donationEventPage.getContent();
        int totalPage = donationEventPage.getTotalPages();
        
        model.addAttribute("donationEvents", donationEvents);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("searchText", searchText);
        model.addAttribute("searchType", searchType);
        model.addAttribute("sortType", sortType);

        return filterService.filterAdmin(request, model, "donationEventManagement");
    }
    
    @GetMapping("donation-management")
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

    @GetMapping("my-donations")
    public String myDonations(Model model, HttpServletRequest request) {
      
        return filterService.filterUser(request, model, "myDonations");
    }

}
