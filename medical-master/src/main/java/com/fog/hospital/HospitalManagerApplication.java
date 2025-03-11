package com.fog.hospital;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.fog.hospital.mapper")
@SpringBootApplication
@Slf4j
public class HospitalManagerApplication {

    public static void main(String[] args) {
        SpringApplication.run(HospitalManagerApplication.class, args);
        log.info("启动成功");
    }

}

