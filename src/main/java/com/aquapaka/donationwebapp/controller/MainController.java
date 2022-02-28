package com.aquapaka.donationwebapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.model.state.AppUserState;
import com.aquapaka.donationwebapp.model.state.Role;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.service.DonationEventService;
import com.aquapaka.donationwebapp.service.DonationService;
import com.aquapaka.donationwebapp.service.FilterService;

import org.springframework.beans.factory.annotation.Autowired;
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
    public String index(Model model, HttpServletRequest request) {
        // Get donation events data
        List<DonationEvent> donationEvents = donationEventService.getDonationEvents();
        model.addAttribute("donationEvents", donationEvents);

        return filterService.filterGuest(request, model, "index");
    }

    @GetMapping("userManagement")
    public String userManagement(Model model, HttpServletRequest request) {

        // Get appUser datas
        List<AppUser> appUsers = appUserService.getAppUsers();
        model.addAttribute("appUsers", appUsers);

        return filterService.filterAdmin(request, model, "userManagement");
    }
    
    @GetMapping("donationEventManagement")
    public String donationEventManagement(Model model, HttpServletRequest request,
    @RequestParam(value = "searchText", required = false, defaultValue = "") String searchText,
    @RequestParam(value = "searchType", required = false, defaultValue = "") String searchType) {

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
