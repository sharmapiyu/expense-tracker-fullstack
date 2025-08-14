package com.example.expensetracker.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public class RegisterRequest {
    @Email @NotBlank
    private String email;
    @NotBlank
    private String password;

    public RegisterRequest() {}
    public RegisterRequest(String email, String password) { this.email = email; this.password = password; }

    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
}
