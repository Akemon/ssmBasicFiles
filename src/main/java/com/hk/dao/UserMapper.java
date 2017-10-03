package com.hk.dao;

import com.hk.bean.User;
import com.hk.bean.UserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

public interface UserMapper {
    long countByExample(UserExample example);

    int deleteByExample(UserExample example);

    int deleteByPrimaryKey(Integer userId);

    int insert(User record);

    int insertSelective(User record);

    List<User> selectByExample(UserExample example);

    //带部门信息的查询
    @Select({"select * from tb_test_user u,tb_test_dept d where u.dept_Id=d.dept_Id and name like concat(concat('%',#{searchString}),'%')"})
    @ResultMap("WithDeptBaseResultMap")
    List<User> selectAllUserWithDept(@Param("searchString")String searchString);

    User selectByPrimaryKey(Integer userId);

    int updateByExampleSelective(@Param("record") User record, @Param("example") UserExample example);

    int updateByExample(@Param("record") User record, @Param("example") UserExample example);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
}