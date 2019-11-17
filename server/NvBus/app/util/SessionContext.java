package util;

import play.db.jpa.JPA;

public class SessionContext {
	public static void setRollbackOnly(){
		JPA.em().getTransaction().rollback();
	}
}
