package cn.nova.bus.archive.model.zzbmodel;

import java.io.Serializable;
import java.util.List;

/**
 * @Author: 仉~~
 * @Date: 2019-01-16 9:28
 * @Description:  返回参数封装
 */
public class RspBody implements Serializable {
    private static final long serialVersionUID = 7946144277469997757L;

    private List<UserList> userList;

    public List<UserList> getUserList() {
        return userList;
    }

    public void setUserList(List<UserList> userList) {
        this.userList = userList;
    }
}
