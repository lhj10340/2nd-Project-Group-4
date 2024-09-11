package kr.tf.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.tf.spring.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	
	
	@Autowired
	private UserService userService;
	
	
	@GetMapping("/tool")
	public String tool(Model mo, HttpSession session) {
		return "/admin/tool";
	}
}
