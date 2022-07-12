
import br.unb.cic.mop.Employee;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.util.*;

import java.lang.ref.*;
import org.aspectj.lang.*;

aspect BaseAspect {
	pointcut notwithin() :
	!within(sun..*) &&
	!within(java..*) &&
	!within(javax..*) &&
	!within(com.sun..*) &&
	!within(org.dacapo.harness..*) &&
	!within(org.apache.commons..*) &&
	!within(org.apache.geronimo..*) &&
	!within(net.sf.cglib..*) &&
	!within(mop..*) &&
	!within(javamoprt..*) &&
	!within(rvmonitorrt..*) &&
	!within(com.runtimeverification..*);
}

public aspect EmployeeSpecMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public EmployeeSpecMonitorAspect(){
	}

	// advices for Statistics
	after () : execution(* org.apache.maven.surefire.booter.ForkedBooter.runSuitesInProcess(..)) {
		System.err.println("==start EmployeeSpec ==");
		System.err.println("#monitors: " + EmployeeSpecMonitor.getTotalMonitorCount());
		System.err.println("#collected monitors: " + EmployeeSpecMonitor.getCollectedMonitorCount());
		System.err.println("#terminated monitors: " + EmployeeSpecMonitor.getTerminatedMonitorCount());
		System.err.println("#event - c3: " + EmployeeSpecMonitor.getEventCounters().get("c3"));
		System.err.println("#event - total: " + EmployeeSpecMonitor.getEventCounters().get("total"));
		System.err.println("#event - invalidCut: " + EmployeeSpecMonitor.getEventCounters().get("invalidCut"));
		System.err.println("#event - validSalary: " + EmployeeSpecMonitor.getEventCounters().get("validSalary"));
		System.err.println("#event - invalidSalary: " + EmployeeSpecMonitor.getEventCounters().get("invalidSalary"));
		System.err.println("#event - c1: " + EmployeeSpecMonitor.getEventCounters().get("c1"));
		System.err.println("#event - validCut: " + EmployeeSpecMonitor.getEventCounters().get("validCut"));
		System.err.println("#event - c2: " + EmployeeSpecMonitor.getEventCounters().get("c2"));
		System.err.println("#category - prop 1 - fail: " + EmployeeSpecMonitor.getCategoryCounters().get("fail"));
		System.err.println("#category - prop 1 - final: " + EmployeeSpecMonitor.getCategoryCounters().get("final"));
		System.err.println("#category - prop 1 - error: " + EmployeeSpecMonitor.getCategoryCounters().get("error"));
		System.err.println("==end EmployeeSpec ==");
	}
	// Declarations for the Lock
	static ReentrantLock EmployeeSpec_MOPLock = new ReentrantLock();
	static Condition EmployeeSpec_MOPLock_cond = EmployeeSpec_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut EmployeeSpec_validCut(int percentage, Employee emp) : (call(public void Employee.cutSalary(int)) && args(percentage) && target(emp)) && MOP_CommonPointCut();
	before (int percentage, Employee emp) : EmployeeSpec_validCut(percentage, emp) {
		//EmployeeSpec_invalidCut
		EmployeeSpecRuntimeMonitor.EmployeeSpec_invalidCutEvent(percentage, emp);
		//EmployeeSpec_validCut
		EmployeeSpecRuntimeMonitor.EmployeeSpec_validCutEvent(percentage, emp);
	}

	pointcut EmployeeSpec_validSalary(double salary, Employee emp) : (call(public void Employee.setSalary(double)) && target(emp) && args(salary)) && MOP_CommonPointCut();
	before (double salary, Employee emp) : EmployeeSpec_validSalary(salary, emp) {
		//EmployeeSpec_invalidSalary
		EmployeeSpecRuntimeMonitor.EmployeeSpec_invalidSalaryEvent(salary, emp);
		//EmployeeSpec_validSalary
		EmployeeSpecRuntimeMonitor.EmployeeSpec_validSalaryEvent(salary, emp);
	}

	pointcut EmployeeSpec_c1() : (call(public Employee.new(String))) && MOP_CommonPointCut();
	after () returning (Employee emp) : EmployeeSpec_c1() {
		EmployeeSpecRuntimeMonitor.EmployeeSpec_c1Event(emp);
	}

	pointcut EmployeeSpec_c2(String name, double salary) : (call(public Employee.new(String, double)) && args(name, salary)) && MOP_CommonPointCut();
	after (String name, double salary) returning (Employee emp) : EmployeeSpec_c2(name, salary) {
		//EmployeeSpec_c2
		EmployeeSpecRuntimeMonitor.EmployeeSpec_c2Event(name, salary, emp);
		//EmployeeSpec_c3
		EmployeeSpecRuntimeMonitor.EmployeeSpec_c3Event(name, salary, emp);
	}

	pointcut EmployeeSpec_total(Employee emp) : (call(public double Employee.totalSalary()) && target(emp)) && MOP_CommonPointCut();
	after (Employee emp) : EmployeeSpec_total(emp) {
		EmployeeSpecRuntimeMonitor.EmployeeSpec_totalEvent(emp);
	}

}
