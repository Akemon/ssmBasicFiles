package com.hk.service;

import com.hk.bean.User;
import com.hk.bean.UserExample;
import com.hk.dao.UserMapper;
import org.omg.Messaging.SYNC_WITH_TRANSPORT;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    UserMapper userMapper;

    /**
     * 获取所有用户
     * @return 保存用户对象的List
     */
    public List<User> getAllUsers() {
        return userMapper.selectAllUserWithDept();

    }

    /**
     * 添加用户
     * @param  user
     */
    public boolean addUser(User user) {
       int flag= userMapper.insertSelective(user);
     //  System.out.println(flag);
       if(flag!=0) return true;
       return false;
    }

    /**
     * 查看用户名是否重复
     * @param loginName
     * @return
     */
    public boolean checkLoginName(String loginName) {
        UserExample userExample =new UserExample();
        UserExample.Criteria criteria= userExample.createCriteria();
        criteria.andLoginNameEqualTo(loginName);
        long count =userMapper.countByExample(userExample);
        return count==0;
    }
}
