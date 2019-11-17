/**
 * <b>项目名：</b>NvDataSyncEJB<br/>
 * <b>包名：</b>cn.nova.datasync.model<br/>
 * <b>文件名：</b>SyncDeleteEntity.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-11-26-下午06:33:19<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.price.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * <b>类描述：</b>该类记录被同步的其他表中的记录被物理删除的情况，用于同步在上级机构中删除对应的记录。
 * 需要注意以下几点：<br/>
 * 1.该同步删除的实现仅支持只上传不下载的数据;<br/>
 * 2.同步删除的实体类必须有同步码字段;<br/>
 * 3.同步删除的信息也只会被上传不会被下载;<br/>
 * <b>类名称：</b>SyncDeleteEntity<br/>
 * <b>创建人：</b><a href="mailto:lanhao@nova.net.cn">兰浩</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@Entity
@Table(name="SYNC_DELETE_ENTITY")
public class SyncDeleteEntity implements Serializable {
  private static final long serialVersionUID = -1972729788562658444L;

  @Id
  @SequenceGenerator(name="SYNCDELETEENTITY_ID_GENERATOR", sequenceName="SEQ_DELETE_ENTITY",allocationSize=1)
  @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SYNCDELETEENTITY_ID_GENERATOR")
  @Column(unique=true, nullable=false, precision=10)
  private long id;
  
  private String tablename;
  
  /**
   * dataid:被删除的数据在本机构的id，在删除之前，该值为空
   */
  @Column(precision=10)
  private Long dataid=null;
  
  /**
   * sourceid:sync_delete_entity表的记录在下面机构的id，也就是上传上来的那个机构的id
   */
  @Column(precision=10,nullable=true,updatable=false)
  private Long sourceid=null;
  
  @Temporal( TemporalType.TIMESTAMP)
  @Column(nullable=false,updatable=false)
  private Date deletetime;
  
  @Temporal( TemporalType.TIMESTAMP)
  @Column(nullable=false)
  private Date createtime;
  
  @Temporal( TemporalType.TIMESTAMP)
  @Column(nullable=false)
  private Date updatetime;
  
  @Column(nullable = false, length = 40, updatable=false)
  private String synccode;
  
  public static final int STATUS_LOGICAL_DELETED=0;
  public static final int STATUS_PHYSICAL_DELETED=1;
  public static final int STATUS_MAYBE_NOT_EXIST=2;
  
  @Column(nullable=false)
  private int status=STATUS_PHYSICAL_DELETED;
  
  @Column(nullable=true)
  private Long orgid;
  
  /************************************************************************************
   **********************************构造函数*******************************************
   ************************************************************************************/
  /**
   * SyncDeleteEntity的构造函数，用于创建新实例
   * 这个构造函数主要用于使用监听器记录数据删除情况时，生成SyncDeleteEntity实例
   * @param clzz 被删除对象的类对象
   * @param dataid 被删除的数据id
   * @param synccode 被删除数据的同步码
   * @param orgid 被删除数据的组织机构id
   */
  public SyncDeleteEntity(Class<?> clzz, long dataid, String synccode, Long orgid){
    super();
    this.tablename=clzz.getName();
    this.dataid=dataid;
    this.synccode=synccode;
    this.createtime = new Date();
    this.updatetime = this.createtime;
    this.deletetime = this.updatetime;
    this.orgid=orgid;
  }

  public SyncDeleteEntity() {
    super();
  }

  /************************************************************************************
   ****************************getter and setter****************************************
   ************************************************************************************/
  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getTablename() {
    return tablename;
  }

  public void setTablename(String tablename) {
    this.tablename = tablename;
  }

  public Long getDataid() {
    return dataid;
  }

  public void setDataid(Long dataid) {
    this.dataid = dataid;
  }

  public String getSynccode() {
    return synccode;
  }

  public void setSynccode(String synccode) {
    this.synccode = synccode;
  }

  public Date getCreatetime() {
    return createtime;
  }

  public void setCreatetime(Date createtime) {
    this.createtime = createtime;
  }

  public Date getUpdatetime() {
    return updatetime;
  }

  public void setUpdatetime(Date updatetime) {
    this.updatetime = updatetime;
  }

  public int getStatus() {
    return status;
  }

  public void setStatus(int status) {
    this.status = status;
  }

  public Long getOrgid() {
    return orgid;
  }

  public void setOrgid(Long orgid) {
    this.orgid = orgid;
  }

  public Date getDeletetime() {
    return deletetime;
  }

  public void setDeletetime(Date deletetime) {
    this.deletetime = deletetime;
  }

  public Long getSourceid() {
    return sourceid;
  }

  public void setSourceid(Long sourceid) {
    this.sourceid = sourceid;
  }
}