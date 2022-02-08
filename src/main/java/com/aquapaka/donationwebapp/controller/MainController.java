package com.aquapaka.donationwebapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.aquapaka.donationwebapp.model.DonationEvent;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

@Controller
public class MainController {
    
    @GetMapping("/")
    public String index(Model model, HttpServletRequest request) {
        // Call API
        String uri =  "http://localhost:8080/api/donationEvent";
        RestTemplate restTemplate = new RestTemplate();
        String restResponse = restTemplate.getForObject(uri, String.class);

        // Map json string into list object
        ObjectMapper mapper = new ObjectMapper().findAndRegisterModules();
        List<DonationEvent> donationEvents;
        try {
            donationEvents = mapper.readValue(restResponse, new TypeReference<List<DonationEvent>>() {}); 
        } catch (Exception e) {
            System.out.println(e);
            return "index";
        }
        model.addAttribute("donationEvents", donationEvents);

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String)session.getAttribute("email");
        String password = (String)session.getAttribute("password");
        
        System.out.println(isLoggedIn);

        
        return "index";
    }
    
}
