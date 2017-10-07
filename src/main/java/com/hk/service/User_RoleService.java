package com.hk.service;

import com.hk.bean.Role;
import com.hk.bean.User_Role;
import com.hk.bean.User_RoleExample;
import com.hk.dao.User_RoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class User_RoleService {
    @Autowired
    User_RoleMapper user_roleMapper;

    /**
     * 添加身份
     * @param user_role
     */
    public  void add_Role(User_Role user_role){
        user_roleMapper.insertSelective(user_role);
    }

    /**
     * 获取身份
     * @param id
     * @return
     */
    public List<User_Role> getUserRole(Integer id){
        User_RoleExample user_roleExample =new User_RoleExample();
        User_RoleExample.Criteria criteria= user_roleExample.createCriteria();
        criteria.andUserIdEqualTo(id);
        List<User_Role> user_roles=user_roleMapper.selectByExample(user_roleExample);
        return user_roles;
    }

    public void deleteUserRole(Integer id){
        User_RoleExample user_roleExample =new User_RoleExample();
        User_RoleExample.Criteria criteria= user_roleExample.createCriteria();
        criteria.andUserIdEqualTo(id);
        user_roleMapper.deleteByExample(user_roleExample);
    }
}
