<?php

class Server_model extends CI_Model
{

	private $server_id = -1; // If -1, not yet loaded.
	public $owner_id = -1;
	public $server_reg_ip = ''; // registered IP, in octets, converted automatically at savetime
	public $server_key = ''; // API key
	
	static const SUCCESS = 0;
	static const NO_SERVER = -1;
	
	function __construct()
	{
		// Call default constructor
		parent::__construct();
	}
	
	function load($new_id)
	{
		$this->server_id = -1; // Reset
		$q = $this->db->get_where('servers', array('server_id' => $new_id), 1, 0);
		if ($q->num_rows() == 0)
		{
			return self::NO_SERVER;
		}
		// Continue!
		$result = $q->result();
		$this->load_result($result);
		return self::SUCCESS;
	}
	
	private function load_result($result)
	{
		$this->server_id = $result->server_id;
		$this->owner_id = $result->owner_id;
		$this->server_reg_ip = long2ip($result->server_reg_ip); // Convert to octets
		$this->server_key = $result->server_key;
	}
	
	function load_api_key($api_key)
	{
		$this->server_id = -1;
		$q = $this->db->get_where('servers', array('server_key' => $api_key), 1, 0);
		if ($q->num_rows() == 0)
		{
			return self::NO_SERVER;
		}
		$this->load_result($q->result());
		return self::SUCCESS;
	}
	
	function save($createnew = -5)
	{
		// Convert IP back to long
		$this->server_reg_ip = ip2long($this->server_reg_ip);
	
		if ($createnew === -5)
		{
			// Auto-detect!
			if ($this->server_id == -1)
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
		
		// Convert long IP back to IP
		$this->server_reg_ip = long2ip($this->server_reg_ip);
	}
	
	private function insert()
	{
		$this->db->insert('servers', $this);
				
		// Set ID
		$this->server_id = $this->db->insert_id();
	}
	
	private function update()
	{
		if ($this->server_id == -1)
		{
			show_error('A database error occurred!');
		}
		$this->db->update('servers', $this, array('server_id' => $this->server_id));
	}
}