package controllers.DepartinvoicesotherJl.dao;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

import javax.persistence.Query;
import java.util.List;

public class DepartinvoicesotherJlDao extends EntityManagerDaoSurport {

    public List<Object> query(List<PropertyFilter> propertyFilterList){
        StringBuilder sb = new StringBuilder("select 1 as testfield from dual where 1=1 ");
        sb.append(PropertyFilter.toJpql(propertyFilterList, true));
        Query query = getEntityManager().createNativeQuery(sb.toString());
        JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
        return query.getResultList();
    }
}
