package com.hk.dao;

import com.hk.bean.User_Role;
import com.hk.bean.User_RoleExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface User_RoleMapper {
    long countByExample(User_RoleExample example);

    int deleteByExample(User_RoleExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(User_Role record);

    int insertSelective(User_Role record);

    List<User_Role> selectByExample(User_RoleExample example);

    User_Role selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") User_Role record, @Param("example") User_RoleExample example);

    int updateByExample(@Param("record") User_Role record, @Param("example") User_RoleExample example);

    int updateByPrimaryKeySelective(User_Role record);

    int updateByPrimaryKey(User_Role record);
}