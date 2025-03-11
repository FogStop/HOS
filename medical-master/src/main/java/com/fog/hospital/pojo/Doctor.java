package com.fog.hospital.pojo;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelTarget;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@TableName("doctor")
@ExcelTarget("doctor")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Doctor implements Serializable {
    @JsonProperty("dId")
    @TableId(value = "d_id")
    @Excel(name = "账号")
    private Integer dId;
    @JsonProperty("dPassword")
    @Excel(name = "密码")
    private String dPassword;
    @JsonProperty("dName")
    @Excel(name = "姓名")
    private String dName;
    @JsonProperty("dGender")
    @Excel(name = "性别")
    private String dGender;
    @JsonProperty("dCard")
    @Excel(name = "身份证号码")
    private String dCard;
    @JsonProperty("dEmail")
    @Excel(name = "邮箱")
    private String dEmail;
    @JsonProperty("dPhone")
    @Excel(name = "手机号")
    private String dPhone;
    @JsonProperty("dPost")
    @Excel(name = "职位")
    private String dPost;
    @JsonProperty("dIntroduction")
    @Excel(name = "简介")
    private String dIntroduction;
    @JsonProperty("dSection")
    @Excel(name = "科室")
    private String dSection;
    @JsonProperty("dState")
    @Excel(name = "是否在职", replace = {"在职_1","离职_0"})
    private Integer dState;//必须为integer类型，为int类型的话更新时会自动更新为0
    @JsonProperty("dPrice")
    @Excel(name = "挂号价格")
    private Double dPrice;
    @JsonProperty("dPeople")
    @Excel(name = "评价人数")
    private Integer dPeople;//必须为integer类型，为int类型的话更新时会自动更新为0
    @JsonProperty("dStar")
    @Excel(name = "总分")
    private Double dStar;//必须为integer类型，为int类型的话更新时会自动更新为0
    @JsonProperty("dAvgStar")
    @Excel(name = "平均分")
    private Double dAvgStar;//必须为integer类型，为int类型的话更新时会自动更新为0

    /**
     * 是否已排班，排班id
     */
    @TableField(exist = false)
    private String arrangeId;
}
