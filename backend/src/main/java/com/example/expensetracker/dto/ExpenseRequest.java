package com.example.expensetracker.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;

public class ExpenseRequest {
    @NotBlank
    private String description;
    @NotNull
    private BigDecimal amount;
    @NotNull
    private LocalDate date;

    public ExpenseRequest() {}
    public ExpenseRequest(String description, BigDecimal amount, LocalDate date) {
        this.description = description; this.amount = amount; this.date = date;
    }

    public String getDescription() { return description; }
    public BigDecimal getAmount() { return amount; }
    public LocalDate getDate() { return date; }

    public void setDescription(String description) { this.description = description; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public void setDate(LocalDate date) { this.date = date; }
}
