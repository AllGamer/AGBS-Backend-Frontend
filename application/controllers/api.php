<?php

class Api extends CI_Controller {

	function __construct()
	{
		parent::__construct();
		$this->load->model('server');
		$this->_get_output_type();
	}
	
	function _output($output)
	{
		// Final processing.
		$outputtype = $this->_get_output_type();
		if ($outputtype == 'ser')
		{
			echo $output;
		}
		else if ($outputtype = 'json')
		{
			echo json_encode(unserialize($output));
		}
		else if ($outputtype = 'xml')
		{
			echo '<?xml version="1.0"><output><status>fail</status><reason>Unimplemented.</reason></output>';
		}
	}
	
	private function _get_output_type()
	{
		$uri = $this->uri->uri_string();
		$ext = pathinfo($uri, PATHINFO_EXTENSION);
		$outputs = array('json' => true, 'xml' => true, 'ser' => true);
		if (isset($outputs[$ext])) return $ext;
		show_error('Output format not valid!', 403);
	}
	
	private function _check_apikey()
	{
		$apikey = $this->input->get_post('apikey');
		if ($apikey === FALSE)
		{
			show_error('API key required!', 403);
			return false;
		}
		$r = $this->server->load_api_key($apikey);
		if (Server_model::NO_SERVER == $r)
		{
			show_error('API key invalid!', 403);
			return false;
		}
		return true; // SUCCESS
	}

	function heartbeat()
	{
		if (!$this->_check_apikey()) return false; // Check API key validity
		$this->output->set_output(serialize(array('status'=>'fail', 'reason'=>'nyi!')));
	}
}