<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class WelcomeController extends AOmegaController {
	public function __construct(){
    	parent::__construct();
    }

	public function index(){
		/*
		$profile = new Profile(NULL);
		$profile->where('login', 'MpaK')->where('password', sha1('123'))->get();

		// Loop through to see all related users
		foreach ($profile as $p){
			echo $p->service_name . '<br />' ;
			echo $p->user->nick . '<br />';
			echo '<hr />';
		}
		 */
		#$module =  modules::load( 'blog' );
		//echo modules::run( 'blog/index', 'MpaK', 'Hello' );
#		print_r( $this->blog );
#		echo "hell-o";
#		$this->load->view('welcome_message');
	}

}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */