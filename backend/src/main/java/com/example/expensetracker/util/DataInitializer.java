package com.example.expensetracker.util;

import com.example.expensetracker.entity.User;
import com.example.expensetracker.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final PasswordEncoder encoder;

    public DataInitializer(UserRepository userRepository, PasswordEncoder encoder) {
        this.userRepository = userRepository;
        this.encoder = encoder;
    }

    @Override
    public void run(String... args) {
        String email = "test@example.com";
        if (!userRepository.existsByEmail(email)) {
            User u = new User(email, encoder.encode("password123"), "ROLE_USER");
            userRepository.save(u);
            System.out.println("Seeded user: " + email + " / password123");
        }
    }
}
