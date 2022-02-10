package com.aquapaka.donationwebapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.model.status.RegisterStatus;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.service.DonationEventService;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

    @Autowired
    private DonationEventService donationEventService;

    @Autowired
    private AppUserService appUserService;
    
    @GetMapping("/")
    public String index(Model model, HttpServletRequest request) {
        // Get donation events data
        List<DonationEvent> donationEvents = donationEventService.getDonationEvents();
        model.addAttribute("donationEvents", donationEvents);

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String)session.getAttribute("email");
        String password = (String)session.getAttribute("password");
        AppUser appUser = appUserService.validateAppUser(email, password);
        boolean isSignedIn = false;

        if(appUser != null) {
            isSignedIn = true;
        }
        model.addAttribute("appUser", appUser);
        model.addAttribute("isSignedIn", isSignedIn);
        
        return "index";
    }

    @PostMapping("/doLogin")
    public @ResponseBody String doLogin(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AppUser appUser = appUserService.validateAppUser(email, password);
        if(appUser == null) {
            return "false";
        }

        HttpSession session = request.getSession();
        session.setAttribute("email", email);
        session.setAttribute("password", password);
        
        return "true";
    }

    @PostMapping("/doRegister")
    public @ResponseBody String doRegister(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        RegisterStatus registerStatus = appUserService.registerAppUser(username, email, password);

        // Map register status object into json string
        ObjectMapper mapper = new ObjectMapper();
        String json = "";
        try {
            json = mapper.writeValueAsString(registerStatus);
        } catch (Exception e) {
            System.out.println(e);
        }

        if(registerStatus.isRegisterSuccess()) {
            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("password", password);
        }
        
        return json;
    }

    @GetMapping("/signOut")
    public String signOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.setAttribute("email", null);
        session.setAttribute("password", null);

        return "redirect:/";
    }
    
}
