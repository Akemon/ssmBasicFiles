package com.hk.service;

import com.hk.bean.Role;
import com.hk.dao.RoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleService {
    @Autowired
    RoleMapper roleMapper;

    /**
     * 获取所有的身份
     * @return
     */
    public List<Role> getAllRoles() {
        return roleMapper.selectByExample(null);

    }
}
