package controllers.DepartinvoicesotherJl.dao;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

import javax.persistence.Query;
import java.util.List;

public class DepartinvoicesotherJlDao extends EntityManagerDaoSurport {

    public List<Object> query(List<PropertyFilter> propertyFilterList){
        StringBuilder sb = new StringBuilder("select o.id,o.code,o.name,o.type,o.parentid,o.serversaddress,o.stationid,o.isactive,o.createtime,o.updatetime,o.districtid,o.islocal,o.synccode " +
                " from organization o where 1=1 ");
        sb.append(PropertyFilter.toJpql(propertyFilterList, true));
        Query query = getEntityManager().createNativeQuery(sb.toString());
        JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
        return query.getResultList();
    }
}
