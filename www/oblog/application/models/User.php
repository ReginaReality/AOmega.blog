<?php

class User extends DataMapper{

    public
		$has_many = array('account')
	;

    // Optionally, don't include a constructor if you don't need one.
    public function __construct($id = NULL){
        parent::__construct($id);
    }


}