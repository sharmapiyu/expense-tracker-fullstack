package com.example.expensetracker.controller;

import com.example.expensetracker.dto.ExpenseRequest;
import com.example.expensetracker.entity.Expense;
import com.example.expensetracker.service.ExpenseService;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/expenses")
public class ExpenseController {

    private final ExpenseService service;

    public ExpenseController(ExpenseService service) { this.service = service; }

    @GetMapping
    public List<Expense> list(@AuthenticationPrincipal UserDetails user) {
        return service.list(user.getUsername());
    }

    @PostMapping
    public Expense create(@AuthenticationPrincipal UserDetails user,
                          @Valid @RequestBody ExpenseRequest req) {
        return service.create(user.getUsername(), req);
    }

    @PutMapping("/{id}")
    public Expense update(@AuthenticationPrincipal UserDetails user,
                          @PathVariable Long id,
                          @Valid @RequestBody ExpenseRequest req) {
        return service.update(user.getUsername(), id, req);
    }

    @DeleteMapping("/{id}")
    public String delete(@AuthenticationPrincipal UserDetails user, @PathVariable Long id) {
        service.delete(user.getUsername(), id);
        return "Deleted";
    }
}
