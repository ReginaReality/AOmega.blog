<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Основной контроллер блога
 * он будет собирать
 * index - ленту постов с PRIMARY модулем
 * show  - показывать пост собрав для него все модули
 * tag   - фильтровать по тэгу
 * date  - фильтровать по дате
 *
 * @version 1.0
 * @author 
 * @copyright Copyright (c) 2011 http://www.AOmega.ru
 */
class BlogController extends AOmegaController{

	public function __construct(){
		parent::__construct();
	}

	/**
	 * 
	 */
	public function index(){
		redirect('user/login');
	}

}