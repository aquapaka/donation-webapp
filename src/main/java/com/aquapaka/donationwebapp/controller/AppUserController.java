package com.aquapaka.donationwebapp.controller;

import java.security.NoSuchAlgorithmException;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.state.AppUserState;
import com.aquapaka.donationwebapp.model.state.Role;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.util.CodeGenerator;
import com.aquapaka.donationwebapp.util.PasswordEncrypt;
import com.aquapaka.donationwebapp.validator.status.RegisterStatus;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.aspectj.apache.bcel.classfile.Code;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AppUserController {
    
    @Autowired
    private AppUserService appUserService;

    @Autowired
    public JavaMailSender emailSender;

    @PostMapping("/doLogin")
    public @ResponseBody String doLogin(HttpServletRequest request,
    @RequestParam String email,
    @RequestParam String password) {

        String encryptedPassword;
        try {
            encryptedPassword = PasswordEncrypt.toHexString(PasswordEncrypt.getSHA(password));
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException(e);
        }

        AppUser appUser = appUserService.validateLogin(email, encryptedPassword);
        
        if(appUser == null) {
            return "false";
        }

        HttpSession session = request.getSession();
        session.setAttribute("email", email);
        session.setAttribute("password", encryptedPassword);
        
        return "true";
    }

    @PostMapping("/doRegister")
    public @ResponseBody RegisterStatus doRegister(HttpServletRequest request,
    @RequestParam String username,
    @RequestParam String email,
    @RequestParam String password) {

        RegisterStatus registerStatus = appUserService.registerAppUser(username, email, password);
        
        // Save user email and password into session if register success
        if(registerStatus.isRegisterSuccess()) {
            String encryptedPassword;
            try {
                encryptedPassword = PasswordEncrypt.toHexString(PasswordEncrypt.getSHA(password));
            } catch (NoSuchAlgorithmException e) {
                throw new IllegalStateException(e);
            }

            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("password", encryptedPassword);
        }
        
        return registerStatus;
    }

    @GetMapping("/signOut")
    public String signOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.setAttribute("email", null);
        session.setAttribute("password", null);

        return "redirect:/";
    }

    @GetMapping("/validateEmail")
    public String validateEmail(HttpServletRequest request, HttpServletResponse response, Model model) {
        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);

        if (appUser == null || appUser.getState() == AppUserState.ACTIVE) {
            return "redirect:/";
        }

        // Generate and send code to user email
        int code = CodeGenerator.generateCode();
        SimpleMailMessage message = new SimpleMailMessage();

        message.setTo(email);
        message.setSubject("Validation your email - DONATION");
        message.setText("Your validation code is " + code);

        // Send Message!
        emailSender.send(message);

        appUserService.updateAppUserCodeById(appUser.getAppUserId(), code);

        model.addAttribute("appUser", appUser);
        model.addAttribute("isSignedIn", true);

        return "validateEmail";
    }

    @PostMapping("/validateCode")
    public @ResponseBody boolean validateCode(HttpServletRequest request, @RequestParam int code) {
        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);

        return appUserService.validateActiveCode(appUser.getAppUserId(), code);
    }

    @GetMapping("/AppUser/{id}")
    public @ResponseBody String getAppUser(@PathVariable long id) {
        Optional<AppUser> appUserOptional = appUserService.getAppUserById(id);

        if(appUserOptional.isPresent()) {
            String jsonResponse = "";
            ObjectMapper mapper = new ObjectMapper().findAndRegisterModules();

            try {
                jsonResponse = mapper.writeValueAsString(appUserOptional.get());
            } catch (Exception e) {
                System.out.println(e);
                return "false";
            }

            return jsonResponse;
        } else {
            return "false";
        }
    }

    @DeleteMapping("/AppUser/{id}")
    public @ResponseBody String deleteAppUser(@PathVariable long id) {

        appUserService.deleteAppUserById(id);

        return "true";
    }

    // TODO: Process input data
    @PutMapping("/AppUser/{id}")
    public @ResponseBody String updateAppUser(@PathVariable long id,
    @RequestParam String fullname,
    @RequestParam String dateOfBirth,
    @RequestParam Boolean gender,
    @RequestParam String phoneNumber,
    @RequestParam String role
    ) {
        Role userRole;
        if (role.equals(Role.USER.name())) {
            userRole = Role.USER;
        } else if (role.equals(Role.ADMIN.name())) {
            userRole = Role.ADMIN;
        } else {
            throw new IllegalStateException("Event state not valid!");
        }

        appUserService.updateAppUserInfoById(id, fullname, dateOfBirth, gender, phoneNumber, userRole);
        
        return "true";
    }
}
