package com.example.expensetracker.service;

import com.example.expensetracker.dto.ExpenseRequest;
import com.example.expensetracker.entity.Expense;
import com.example.expensetracker.entity.User;
import com.example.expensetracker.repository.ExpenseRepository;
import com.example.expensetracker.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExpenseService {
    private final ExpenseRepository expenseRepo;
    private final UserRepository userRepo;

    public ExpenseService(ExpenseRepository expenseRepo, UserRepository userRepo) {
        this.expenseRepo = expenseRepo; this.userRepo = userRepo;
    }

    public List<Expense> list(String email) {
        User user = userRepo.findByEmail(email).orElseThrow();
        return expenseRepo.findByUser(user);
    }

    public Expense create(String email, ExpenseRequest req) {
        User user = userRepo.findByEmail(email).orElseThrow();
        Expense e = new Expense(user, req.getDescription(), req.getAmount(), req.getDate());
        return expenseRepo.save(e);
    }

    public Expense update(String email, Long id, ExpenseRequest req) {
        User user = userRepo.findByEmail(email).orElseThrow();
        Expense e = expenseRepo.findByIdAndUser(id, user).orElseThrow();
        e.setDescription(req.getDescription());
        e.setAmount(req.getAmount());
        e.setDate(req.getDate());
        return expenseRepo.save(e);
    }

    public void delete(String email, Long id) {
        User user = userRepo.findByEmail(email).orElseThrow();
        Expense e = expenseRepo.findByIdAndUser(id, user).orElseThrow();
        expenseRepo.delete(e);
    }
}
