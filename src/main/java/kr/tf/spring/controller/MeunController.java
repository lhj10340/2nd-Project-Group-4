package kr.tf.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.tf.spring.service.MenuService;

@Controller
@RequestMapping("/menu")
public class MeunController {
	
	@Autowired
	private MenuService menuService;
	
	@GetMapping("/menu")
	public String menu(Model mo) {
		
		return "/menu/menu";
	}
}
