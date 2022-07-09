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

    @Test(expected = RuntimeException.class)
    public void testInvalidSequence01() {
        Employee emp = new Employee("rbonifacio");
        assertEquals(0.0, emp.totalSalary(), 0.005);
    }
}
