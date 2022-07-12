package br.unb.cic.mop;

import static org.junit.Assert.*;
import org.junit.Test;

public class EmployeeTest {

    @Test
    public void testValidSequence01() {
        Employee emp = new Employee("rbonifacio");
        emp.setSalary(100);
        assertEquals(100.0, emp.totalSalary(), 0.005);
    }

    @Test
    public void testValidSequence02() {
        Employee emp = new Employee("rbonifacio", 100);
        assertEquals(100.0, emp.totalSalary(), 0.005);
    }

    @Test
    public void testValidSequence03() {
        Employee emp = new Employee("rbonifacio", 100);
        emp.setSalary(1000);
        assertEquals(1000.0, emp.totalSalary(), 0.005);
    }

    @Test
    public void testValidSequence04() {
        Employee emp = new Employee("rbonifacio");
        emp.setSalary(1000);
        emp.setSalary(5000);
        assertEquals(5000.0, emp.totalSalary(), 0.005);
    }

    @Test
    public void testValidSequence05() {
        Employee emp = new Employee("rbonifacio");

        emp.setSalary(5000);

        double res = emp.totalSalary();
        assertEquals(5000.0, res, 0.005);

        emp.setSalary(1000);
        res = emp.totalSalary();
        assertEquals(1000.0, res, 0.005);
    }

    @Test
    public void testValidSequence06() {
        Employee emp = new Employee("walter", 200);

        emp.setSalary(5000);

        double res = emp.totalSalary();
        assertEquals(5000.0, res, 0.005);

        emp.setSalary(1000);
        res = emp.totalSalary();
        assertEquals(1000.0, res, 0.005);
    }

    @Test
    public void testValidSequence07() {
        Employee emp = new Employee("rbonifacio", 100);
        emp.cutSalary(90);
        assertEquals(10.0, emp.totalSalary(), 0.005);
    }

    @Test(expected = RuntimeException.class)
    public void testValidSequence08() {
        Employee emp = new Employee("rbonifacio", 100);
        emp.cutSalary(100);
        assertEquals(0.0, emp.totalSalary(), 0.005);
    }

    @Test(expected = RuntimeException.class)
    public void testInvalidSequence01() {
        Employee emp = new Employee("rbonifacio");
        assertEquals(0.0, emp.totalSalary(), 0.005);
    }



}
