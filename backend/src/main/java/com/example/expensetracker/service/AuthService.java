package com.example.expensetracker.service;

import com.example.expensetracker.dto.LoginRequest;
import com.example.expensetracker.dto.RegisterRequest;
import com.example.expensetracker.entity.User;
import com.example.expensetracker.repository.UserRepository;
import com.example.expensetracker.security.JwtUtil;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final UserRepository repo;
    private final PasswordEncoder encoder;
    private final AuthenticationManager authManager;
    private final JwtUtil jwtUtil;

    public AuthService(UserRepository repo, PasswordEncoder encoder,
                       AuthenticationManager authManager, JwtUtil jwtUtil) {
        this.repo = repo;
        this.encoder = encoder;
        this.authManager = authManager;
        this.jwtUtil = jwtUtil;
    }

    public void register(RegisterRequest req) {
        if (repo.existsByEmail(req.getEmail())) {
            throw new IllegalArgumentException("Email already registered");
        }
        User u = new User(req.getEmail(), encoder.encode(req.getPassword()), "ROLE_USER");
        repo.save(u);
    }

    public String login(LoginRequest req) {
        try {
            authManager.authenticate(
                    new UsernamePasswordAuthenticationToken(req.getEmail(), req.getPassword())
            );
        } catch (BadCredentialsException ex) {
            throw new IllegalArgumentException("Invalid credentials");
        }
        return jwtUtil.generateToken(req.getEmail());
    }
}
