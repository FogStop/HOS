package com.fog.hospital.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fog.hospital.pojo.Announcements;
import com.fog.hospital.service.AnnouncementsService;
import com.fog.hospital.utils.ResponseData;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/announcements")
@Slf4j
public class AnnouncementsController {
    @Autowired
    private AnnouncementsService announcementsService;

    @RequestMapping("/list")
    public ResponseData getAnnouncements() {
        List<Announcements> list = announcementsService.list();
        return ResponseData.success("success", list);
    }
    // 分页条件查询
    @GetMapping
    public ResponseData getList(@RequestParam(required = false) String fileName) {
        try {
            QueryWrapper<Announcements> wrapper = new QueryWrapper<>();
            if (StringUtils.isNotBlank(fileName)) {
                wrapper.like("file_name", fileName);
            }
            wrapper.orderByDesc("time");
            return ResponseData.success("查询成功", announcementsService.list(wrapper));
        } catch (Exception e) {
            return ResponseData.fail("查询失败: " + e.getMessage());
        }
    }

    // 新增公告
    @PostMapping
    public ResponseData add(@RequestBody Announcements announcements) {
        try {
            announcements.setTime(new Date()); // 自动设置当前时间
            boolean result = announcementsService.save(announcements);
            return result ? ResponseData.success("新增成功")
                    : ResponseData.fail("新增失败");
        } catch (Exception e) {
            return ResponseData.fail("新增异常: " + e.getMessage());
        }
    }

    // 修改公告
    @PutMapping
    public ResponseData update(@RequestBody Announcements announcements) {
        try {
            boolean result = announcementsService.updateById(announcements);
            return result ? ResponseData.success("更新成功")
                    : ResponseData.fail("更新失败");
        } catch (Exception e) {
            return ResponseData.fail("更新异常: " + e.getMessage());
        }
    }

    // 删除公告
    @DeleteMapping("/{id}")
    public ResponseData delete(@PathVariable Integer id) {
        try {
            boolean result = announcementsService.removeById(id);
            return result ? ResponseData.success("删除成功")
                    : ResponseData.fail("删除失败");
        } catch (Exception e) {
            return ResponseData.fail("删除异常: " + e.getMessage());
        }
    }


}
