package util;

import javax.persistence.EntityTransaction;

import play.db.jpa.JPA;

public class UserTransaction {
	
	public void begin() throws SystemException{		
		if (!JPA.em().getTransaction().isActive()) {
			JPA.em().getTransaction().begin();
		}
		
	}
	
	public void commit() throws SystemException{
		if (JPA.em().getTransaction().isActive()) {
			JPA.em().getTransaction().commit();
		}
	}
	
	public void rollback() throws SystemException{
	   if(JPA.em().getTransaction().isActive()){
		    JPA.em().getTransaction().rollback();
	   }
	}
				
}
