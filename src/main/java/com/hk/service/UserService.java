package com.hk.service;

import com.hk.bean.User;
import com.hk.dao.UserMapper;
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
}
