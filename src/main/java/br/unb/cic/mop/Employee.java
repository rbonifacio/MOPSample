package br.unb.cic.mop;

public class Employee implements WorkUnit {

    private String name;
    private double salary;
    private double bonus = 0;

    public Employee(String name) {
        this.name = name;
    }

    public Employee(String name, double salary) {
        this.name = name;
        this.salary = salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public void setBonus(double bonus) {
        this.bonus = bonus;
    }

    public double totalSalary() {
        return salary + salary * bonus;
    }

    public void cutSalary(int percentage) {
        salary = salary - salary * percentage / 100;
    }
}
