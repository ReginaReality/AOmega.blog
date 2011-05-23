<?php

class Account extends DataMapper{
    public
		$has_one = array('user')
	;

    // Optionally, don't include a constructor if you don't need one.
#    public function __construct($id = NULL){
#        parent::__construct($id);
#    }


}