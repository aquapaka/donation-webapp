package com.aquapaka.donationwebapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.service.DonationEventService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @Autowired
    private DonationEventService donationEventService;
    
    @GetMapping("/")
    public String index(Model model, HttpServletRequest request) {
        List<DonationEvent> donationEvents = donationEventService.getDonationEvents();
        model.addAttribute("donationEvents", donationEvents);

        // // Get account data from session
        // HttpSession session = request.getSession();
        // String email = (String)session.getAttribute("email");
        // String password = (String)session.getAttribute("password");
        
        return "index";
    }
    
}
