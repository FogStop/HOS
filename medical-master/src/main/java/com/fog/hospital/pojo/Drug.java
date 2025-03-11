package com.fog.hospital.pojo;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@TableName("drug")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Drug {
    @TableId(value = "dr_id")
    @JsonProperty("drId")
    private int drId;
    @JsonProperty("drName")
    private String drName;
    @JsonProperty("drPrice")
    private double drPrice;
    @JsonProperty("drNumber")
    private int drNumber;
    @JsonProperty("drUnit")
    private String drUnit;
    @JsonProperty("drPublisher")
    private String drPublisher;
}
