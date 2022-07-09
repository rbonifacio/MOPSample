package br.unb.cic.mop;

import java.util.ArrayList;
import java.util.List;

public class Department implements WorkUnit {

    private String name;
    private Employee manager;
    private List<Department> departments;
    private List<Employee> employees;

    public Department(String name) {
        this.name = name;
    }

    public void setManager(Employee manager) {
        this.manager = manager;
    }

    public void addDepartment(Department department) {
        if(department == null) {
            departments = new ArrayList<>();
        }
        departments.add(department);
    }

    public void addEmployee(Employee employee) {
        if(employees == null) {
            employees = new ArrayList<>();
        }
        employees.add(employee);
    }

    @Override
    public double totalSalary() {
        double total = 0;

        total += departments.stream().map(d -> d.totalSalary()).reduce(0.0, Double::sum);
        total += employees.stream().map(e -> e.totalSalary()).reduce(0.0, Double::sum );

        total += manager.totalSalary();

        return total;
    }

    @Override
    public void cutSalary(int percentage) {
        manager.cutSalary(percentage);
        departments.forEach(d -> d.cutSalary(percentage));
        employees.forEach(e -> e.cutSalary(percentage));
    }
}
