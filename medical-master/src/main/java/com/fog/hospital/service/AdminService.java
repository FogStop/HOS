package com.fog.hospital.service;

import com.fog.hospital.pojo.Admin;

public interface AdminService {
    /**
     * 登录数据校验
     * */
    Admin login(int aId, String aPassword);
}
