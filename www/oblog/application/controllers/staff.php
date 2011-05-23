<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Staff Controller
 */
class StaffController  extends FrontController {
	protected
		$view	=	'staff/'		// template directory
	;

	public function __construct(){
		parent::__construct();
		$this->load->model ( array('staff', 'department', 'shift', 'position', 'staffshift', 'shifthead' ) );
		$this->load->helper( 'staff' );
	}

	/**
	 * Get all staff list
	 */
    public function index(){
		$data = array();
		$data['staff'] = $this->staff->find();
		// render to HTML+JS
		$this->template->render_to( 'content', $this->view.'index', $data );
		$this->template->set( array('page_title'=>'Staff - '.APP_NAME) )->show();
	}

	/**
	 * Get user profile for our form
	 */
	public function profile( $id='' ){
		$id = not_empty( $id, param('id') );
		// check errors, did we received ID and DATE of day
		if( empty($id) ){
			echo "Error: can't find user`s ID";
			return;
		}
		// check him
		$data['user'] = $this->staff->find( (int)$id, 1 );
		if( empty($data['user']) ){
			echo "Error: can't find user with ID: {$id} in our database";
			return;
		}
		// for edit portfolio
		$data['departments'] = $this->departments();
		$data['positions']   = $this->positions();
		// for edit timeshif
		$data['shiftheads']  = $this->shiftheads();
		$data['shifts']      = $this->shifts( $id );
		// everything is OK, let's show form to operator
		$this->template->show( $this->view.'profile', $data );
	}

	/**
	 * There we save or add new staff
	 */
	public function save(){
		$data = params(array(
			'id',
			'nick', 'name',
			'position_id|int', 'department_id|int', 'manager_id|int',
			'address', 'email', 'phone', 'tax|float', 'hipno|int', 'salary|float',
			'passport', 'ss_startdate',
			'bankaccount', 'bankdetail',
			'start_date', 'end_date', 'xemp_code'
			)
		);
		//debug($data);
		if( !empty($data['start_date']) )	$data['start_date']	  = mysql_date( $data['start_date'] );
		if( !empty($data['end_date']) )		$data['end_date']	  = mysql_date( $data['end_date'] );
		if( !empty($data['ss_startdate']) )	$data['ss_startdate'] = mysql_date( $data['ss_startdate'] );
		// glue for scaner mask
		$data['scaner_mask'] = param('scaner_mask1').param('scaner_mask2').param('scaner_mask3').param('scaner_mask4');

		$ok = $this->staff->save( $data );

		if( $ok === FALSE ){
			response_to( array('error' => $ok), FALSE );
		}else{
			$sf = $this->staff->find( $data['id'], 1 );
			response_to( array('ok' => staff_row($sf, TRUE)), FALSE );
		}
	}

	/**
	 * Get all managers id and nick_name
	 *
	 * @return array
	 */
	public function managers(){
		return up_array($this->staff->select('[id],[nick]')->find(), 'nick');
	}

	/**
	 * Get all departments from our database
	 *
	 * @return array
	 */
	private function departments(){
		return up_array( $this->department->select( '[id], [name]' )->department->find(), 'name' );
	}

	/**
	 * Get all positions from our database
	 *
	 * @return array
	 */
	private function positions(){
		return up_array( $this->position->select( '[id],[name]' )->position->find(), 'name' );
	}

	/**
	 * Get all Shift Heads from our database
	 *
	 * @return array
	 */
	private function shiftheads(){
		return up_array( $this->shifthead->select( '[id],[name]' )->find(), 'name' );
	}

	/**
	 * Get users timeshifts
	 *
	 * @return array
	 */
	private function shifts( $id ){
		return $this->staffshift->by_staff( (int) $id );
	}

//---------------------- SHIFTs REST service -----------------------------------

	/**
	 * Update user's time shift
	 */
	public function save_shift( ){
		$data['id']			= param('id|int');
		$data['staff_id']	= param('staff_id|int');
		// break if we dont have user's ID!
		if( empty($data['staff_id']) ) {
			response_to( array('error'=>'Error, Staff ID is empty') );
			return;
		}

		// decode our row params from JSON
		$data['fromdate'] = mysql_date( not_empty(param('fromdate', FALSE, FALSE), now2mysql()) );
		$data['shift_id'] = param('shift_id|int');
		try{
			$id = $this->staffshift->save( $data );
			$data['id'] = $id;
			// make row for return if we create him
			$shiftheads  = $this->shiftheads();
			//$data['shifts']      = $this->shifts( $id );
			$row = shift_row( $data, TRUE, $shiftheads );
			//$id = $data['id'];
			$response = array(
				'msg' => 'Good, TimeShift saved',
				'id'  => $id,
				'row' => $row
			);
		}catch( Exception $e ){
			$response = array(
				'error'	=> $e->getMessage()
			);
		}
		response_to( $response );
		return;
	}

	/**
	 * Delete user's time shift
	 */
	public function delete_shift($id){
		if( empty($id) ) return ;

		$this->staffshift->delete( intval($id) );
		debug( $this->db->last_query() );
		echo 1;
	}
}
