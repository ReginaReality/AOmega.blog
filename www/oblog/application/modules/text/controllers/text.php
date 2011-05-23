<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 *
 */
class TextController extends AOmegaModule {

	public function __construct(){
    	parent::__construct();
    }

	public function index( $name='AOmega', $hello = 'good bye' ){
		echo $hello." timeline of posts: ".$name;
	}

}
