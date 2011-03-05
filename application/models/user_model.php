<?php

class User_model extends CI_Model
{
	private $user_id = -1; // -1 = unloaded, create record, anything = update
	public $email = '';
	public $password = '';
	public $validate_key = '';
	public $create_date = '';
	
	static const SUCCESS = 0;
	static const NO_USER = -1;
	
	function __construct()
	{
		// Call default constructor
		parent::__construct();
	}
	
	function load($new_id)
	{
		$this->user_id = -1;
		// Here goes.
		$q = $this->db->get_where('users', array('user_id' => $new_id), 1, 0);
		if ($q->num_rows() == 0)
		{
			return self::NO_USER;
		}
		
		$result = $q->result();
		$this->user_id = $result->user_id;
		$this->email = $result->email;
		$this->password = $result->password;
		$this->validate_key = $result->validate_key;
		$this->create_date = $result->create_date;
		
		return self::SUCCESS;
	}
	
	function save($createnew = -5)
	{
		if ($createnew === -5)
		{
			// Auto-detect!
			if ($this->user_id == -1)
			{
				$createnew = true;
			}
			else
			{
				$createnew = false;
			}
		}
		
		if ($createnew)
		{
			$this->insert();
		}
		else
		{
			$this->update();
		}
	}
	
	private function insert()
	{
		$this->db->insert('users', $this);
				
		// Set ID
		$this->user_id = $this->db->insert_id();
	}
	
	private function update()
	{
		if ($this->user_id == -1)
		{
			show_error('A database error occurred!');
		}
		$this->db->update('users', $this, array('user_id' => $this->user_id));
	}
}