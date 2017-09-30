package com.hk.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 返回数据的通用类
 */
public class Message {

    //处理状态，100表示处理成功，200表示处理失败
    private int code;

    //提示信息
    private String msg;

    //存储其它数据
    private Map<String,Object> extend =new HashMap<String,Object>();

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    /**
     * 处理成功
     * @return Message对象并初始化
     */
    public static Message success(){
        Message result =new Message();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }

    /**
     * 处理失败
     * @return Message对象对象并初始化
     */
    public static Message fail(){
        Message result =new Message();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }

    /**
     * 为当前Message对象添加其它数据
     * @param key  数据键
     * @param value  数据值
     * @return Message对象
     */
    public Message add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }
}
