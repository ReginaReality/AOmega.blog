<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Контроллер пользователя
 * он будет:
 * index    - показывать профиль залогиненного пользователя
 * login    - вход
 * logout   - выход
 * register - форма и регистрация
 *
 * ----- Желательно сразу продумать и сделать 2х вариантое исполнение
 * как страничка по http
 * так и запрос через AJAX для этого helper/input_helper см. is_ajax функция
 *
 * @version 1.0
 * @author 
 * @copyright Copyright (c) 2011 http://www.AOmega.ru
 */
class UserController extends AOmegaController{
	protected
		$view = 'user/'
	;

	public function __construct(){
		parent::__construct();
	}

	/**
	 *
	 */
	public function index(){
	}

	/**
	 * login: user
	 * password: 123
	 */
	public function login(){
		$data = array();
		if( !empty($_POST) ){
			$profile = new Account(NULL);
			$profile->where('login', param('login'))->where('password', sha1( param('password') ) )->get();

			// Loop through to see all related users
			foreach ($profile as $p){
				echo 'SN: '.$p->service_name . '<br />' ;
				echo 'Nick: '.$p->user->nick . '<br />';
				echo 'Email: '.$p->user->email . '<br />';
				echo '<hr />';
			}

		}else{
			if( is_ajax() ){
			}else{
				$this->template->render_to( 'content', $this->view.'login', $data )->show();
			}
		}
	}

}