package com.fog.hospital.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;


@TableName("announcements")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Announcements {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("file_name")
    private String fileName;

    @TableField("content")
    private String content;

    @TableField("time")
    @JsonFormat(pattern = "yyyy-MM-dd")//yyyy-MM-dd HH:mm:ss样式
    private Date time;
}


