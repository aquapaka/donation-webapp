package com.aquapaka.donationwebapp.controller;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.state.AppUserState;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.util.CodeGenerator;
import com.aquapaka.donationwebapp.util.PasswordEncrypt;
import com.aquapaka.donationwebapp.validator.status.RegisterStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginRegisterController {

    @Autowired
    private AppUserService appUserService;

    @Autowired
    private JavaMailSender emailSender;

    @PostMapping("/do-login")
    public @ResponseBody String doLogin(HttpServletRequest request,
            @RequestParam String email,
            @RequestParam String password) {

        String encryptedPassword;
        try {
            encryptedPassword = PasswordEncrypt.encryptPassword(password);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException(e);
        }

        AppUser appUser = appUserService.validateLogin(email, encryptedPassword);

        if (appUser == null) {
            return "false";
        }

        HttpSession session = request.getSession();
        session.setAttribute("email", email);
        session.setAttribute("password", encryptedPassword);

        return "true";
    }

    @PostMapping("/do-register")
    public @ResponseBody RegisterStatus doRegister(HttpServletRequest request,
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam String password) {

        RegisterStatus registerStatus = appUserService.registerAppUser(username, email, password);

        // Save user email and password into session if register success
        if (registerStatus.isRegisterSuccess()) {
            String encryptedPassword;
            try {
                encryptedPassword = PasswordEncrypt.encryptPassword(password);
            } catch (NoSuchAlgorithmException e) {
                throw new IllegalStateException(e);
            }

            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("password", encryptedPassword);
        }

        return registerStatus;
    }

    @GetMapping("/sign-out")
    public String signOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.setAttribute("email", null);
        session.setAttribute("password", null);

        return "redirect:/";
    }

    @GetMapping("/validate-email")
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

    @PostMapping("/validate-code")
    public @ResponseBody boolean validateCode(HttpServletRequest request, @RequestParam int code) {
        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);

        return appUserService.validateActiveCode(appUser.getAppUserId(), code);
    }
}
