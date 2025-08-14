package com.example.expensetracker.controller;

import com.example.expensetracker.dto.AuthResponse;
import com.example.expensetracker.dto.LoginRequest;
import com.example.expensetracker.dto.RegisterRequest;
import com.example.expensetracker.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService service;

    public AuthController(AuthService service) { this.service = service; }

    @PostMapping("/register")
    public String register(@Valid @RequestBody RegisterRequest request) {
        service.register(request);
        return "Registered";
    }

    @PostMapping("/login")
    public AuthResponse login(@Valid @RequestBody LoginRequest request) {
        String token = service.login(request);
        return new AuthResponse(token);
    }

    @GetMapping("/me")
    public String me(@AuthenticationPrincipal UserDetails user) {
        return (user == null) ? "anonymous" : user.getUsername();
    }
}
